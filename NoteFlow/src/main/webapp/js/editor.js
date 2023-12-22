function getUrlParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}


const loadData = () => {
    $.ajax({
        url: "/noteflow/getNote",
        type: "GET",
        data: {
            idNote: getUrlParam('note'),
        },
        success: function (data) {
            // detect fully html tag in stringifiedData and decode it
            var decodedData = data.replace(/%27/g, "'").replace(/%22/g, '"');

            decodedData = decodeURIComponent(decodedData);

            // replace pattern class="\...\" to class='...'
            decodedData = decodedData.replace(/class=\\"([^\\"]*)\\"/g, "class='$1'");

            // replace pattern style="\...\" to style='...'
            decodedData = decodedData.replace(/style=\\"([^\\"]*)\\"/g, "style='$1'");

            // replace pattern href="\...\" to href='...'
            decodedData = decodedData.replace(/href=\\"([^\\"]*)\\"/g, "href='$1'");

            var jsonData = JSON.parse(JSON.parse(decodedData));
            if (jsonData.blocks && jsonData.blocks.length === 0) {
                jsonData.blocks.push({
                    "id": "",
                    "type": "paragraph",
                    "data": {
                        "text": ""
                    }
                });
            }

            editor.render(jsonData)
                .then(() => {
                    document.getElementById('editorjs').addEventListener('input', function (e) {
                        if (e.inputType === 'insertText' || e.inputType === 'deleteContentBackward') {
                            document.getElementById('isSaving').value = 'true';
                            document.getElementById('savingIcon').classList.remove('hidden');
                            document.getElementById('savedSuccess').classList.add('hidden');
                            document.getElementById('savedFail').classList.add('hidden');
                        }
                    });

                    document.getElementById('editorjs').addEventListener('paste', function (e) {
                        document.getElementById('isSaving').value = 'true';
                        document.getElementById('savingIcon').classList.remove('hidden');
                        document.getElementById('savedSuccess').classList.add('hidden');
                        document.getElementById('savedFail').classList.add('hidden');
                    });

                    const targetNode = document.getElementById('editorjs');

                    const observerOptions = {
                        childList: true,
                        subtree: true
                    };

                    function hasExcludedClass(node) {
                        while (node) {
                            if (node.nodeType === Node.ELEMENT_NODE && (node.classList.contains('ce-toolbar') || node.classList.contains('ce-inline-toolbar'))) {
                                return true;
                            }
                            node = node.parentNode;
                        }
                        return false;
                    }

                    const observer = new MutationObserver(function (mutations) {
                        mutations.forEach(function (mutation) {
                            if (mutation.type === 'childList') {
                                let ignoreMutation = false;
                                mutation.addedNodes.forEach(function (node) {
                                    if (hasExcludedClass(node)) {
                                        ignoreMutation = true;
                                    }
                                });
                                mutation.removedNodes.forEach(function (node) {
                                    if (hasExcludedClass(node)) {
                                        ignoreMutation = true;
                                    }
                                });
                                if (ignoreMutation) {
                                    return;
                                }

                                // Handle other mutations
                                document.getElementById('savingIcon').classList.remove('hidden');
                                document.getElementById('savedSuccess').classList.add('hidden');
                                document.getElementById('savedFail').classList.add('hidden');
                            }
                        });
                    });

                    observer.observe(targetNode, observerOptions);
                })
        }
    })
}



const editor = new EditorJS({
    readOnly: document.getElementById('permission').value == 'Affichage' ? true : false,
    onChange: () => {

        editor.save().then((outputData) => {

            const stringifiedData = JSON.stringify(outputData);
            // detect html tag in stringifiedData and encode it
            const encodedData = stringifiedData.replace(/<[^>]*>/g, function (tag) {
                return encodeURIComponent(tag);
            });


            $.ajax({
                url: "/noteflow/saveNote",
                type: "POST",
                data: {
                    idNote: getUrlParam('note'),
                    content: JSON.stringify(encodedData),
                },
                success: function () {
                    document.getElementById('isSaving').value = 'false';
                    document.getElementById('savingIcon').classList.add('hidden');
                    document.getElementById('savedSuccess').classList.remove('hidden');
                    document.getElementById('savedFail').classList.add('hidden');
                    updateLastModification();
                },
                error: function () {
                    document.getElementById('isSaving').value = 'false';
                    document.getElementById('savingIcon').classList.add('hidden');
                    document.getElementById('savedSuccess').classList.add('hidden');
                    document.getElementById('savedFail').classList.remove('hidden');
                    showToastErrorSaving();
                },
            });

        }).catch((error) => {
            console.log('Saving failed: ', error)
        }
        )
    },
    holder: 'editorjs',
    i18n: {
        messages: {
            ui: {
                "blockTunes": {
                    "toggler": {
                        "Click to tune": "Cliquer pour modifier",
                        "or drag to move": "ou glisser pour déplacer",
                    }
                },
                "inlineToolbar": {
                    "converter": {
                        "Convert to": "Convertir en"
                    }
                },
                "toolbar": {
                    "toolbox": {
                        "Add": "Ajouter"
                    }
                },

            },
            toolNames: {
                "Text": "Texte",
                "Heading": "Titre",
                "List": "Liste",
                "Warning": "Avertissement",
                "Checklist": "Checklist",
                "Quote": "Citation",
                "Code": "Code",
                "Delimiter": "Séparateur",
                "Raw HTML": "HTML brut",
                "Table": "Tableau",
                "Link": "Lien",
                "Marker": "Marqueur",
                "Bold": "Gras",
                "Italic": "Italique",
                "InlineCode": "Code en ligne",
                "Image": "Image",
                "Embed": "Intégrer",
                "Underline": "Souligné",
                "Strike": "Barré",
                "Subscript": "Indice",
                "Superscript": "Exposant"
            },
            tools: {
                "list": {
                    "Unordered": "Liste à puces",
                    "Ordered": "Liste numérotée"
                },
                "stub": {
                    "The block can not be displayed correctly.": "Le bloc ne peut pas être affiché correctement."
                },
                "link": {
                    "Add a link": "Ajouter un lien",
                    "Text to display": "Texte à afficher",
                    "Link": "Lien",
                    "Enter a link": "Entrer un lien",
                    "Add link": "Ajouter un lien",
                    "Apply": "Appliquer",
                    "Cancel": "Annuler"
                },
                "table": {
                    "Insert a table": "Insérer un tableau",
                    "Insert column before": "Insérer une colonne avant",
                    "Insert column after": "Insérer une colonne après",
                    "Insert row above": "Insérer une ligne au dessus",
                    "Insert row below": "Insérer une ligne en dessous",
                    "Delete table": "Supprimer le tableau",
                    "Delete column": "Supprimer la colonne",
                    "Delete row": "Supprimer la ligne",
                    "Add column": "Ajouter une colonne",
                    "Add column to left": "Ajouter une colonne à gauche",
                    "Add column to right": "Ajouter une colonne à droite",
                    "Add row": "Ajouter une ligne",
                    "Add row above": "Ajouter une ligne au-dessus",
                    "Add row below": "Ajouter une ligne en-dessous",
                    "Cell": "Cellule",
                    "Row": "Ligne",
                    "Column": "Colonne",
                    "Without headings": "Sans en-tête",
                    "With headings": "Avec en-tête",
                },
                "embed": {
                    "Embed": "Intégrer",
                    "Enter embed URL": "Entrer l'URL à intégrer",
                    "Paste in a video URL": "Coller l'URL de la vidéo",
                    "Drop an image": "Déposer une image",
                    "Drop an Audio": "Déposer un fichier audio",
                    "Drop a video URL": "Déposer l'URL de la vidéo",
                    "Drop an embed URL or code": "Déposer l'URL ou le code à intégrer",
                    "Or paste embed code": "Ou coller le code à intégrer",
                    "Embed": "Intégrer",
                    "Close": "Fermer"
                },
                "marker": {
                    "Marker": "Marqueur"
                },
                "image": {
                    "Select an Image": "Sélectionner une image",
                    "Select an image": "Sélectionner une image",
                    "Drop an image": "Déposer une image",
                    "or click": "ou cliquer",
                    "to upload": "pour télécharger",
                    "Upload": "Télécharger",
                    "Image URL": "URL de l'image",
                    "Paste image URL": "Coller l'URL de l'image",
                    "Choose an Image": "Choisir une image"
                },
                "raw": {
                    "Raw HTML": "HTML brut"
                },
                "code": {
                    "Code": "Code",
                    "Enter a code": "Ajouter du code",
                    "Code snippet": "Extrait de code"
                },
                "header": {
                    "Heading 1": "Titre 1",
                    "Heading 2": "Titre 2",
                    "Heading 3": "Titre 3",
                    "Heading 4": "Titre 4",
                    "Heading 5": "Titre 5",
                    "Heading 6": "Titre 6",
                    "Heading": "Titre"
                },
                "warning": {
                    "Warning": "Avertissement",
                    "Add a warning": "Ajouter un avertissement",
                    "Message": "Message",
                    "Title": "Titre"
                }
            },
            blockTunes: {
                "delete": {
                    "Delete": "Supprimer"
                },
                "moveUp": {
                    "Move up": "Monter"
                },
                "moveDown": {
                    "Move down": "Descendre"
                },
            },
            "inlineToolbar": {
                "converter": {
                    "Convert to": "Convertir en"
                }
            },
            "link": {
                "link": {
                    "Add a link": "Ajouter un lien"
                }
            },
            "embed": {
                "embed": {
                    "Embed": "Intégrer"
                }
            }
        }
    },
    tools: {
        header: {
            class: Header,
            inlineToolbar: ['link'],
        },
        list: {
            class: List,
            inlineToolbar: true
        },
        table: {
            class: Table,
            inlineToolbar: true,
            config: {
                rows: 2,
                cols: 3,
            }
        },
        Marker: {
            class: Marker,
        },
        list: {
            class: NestedList,
            inlineToolbar: true,
        },
        code: {
            class: CodeTool,
        },
        embed: {
            class: Embed,
            inlineToolbar: true,
            config: {
                services: {
                    youtube: true,
                }
            }
        },
        paragraph: {
            class: Paragraph,
            inlineToolbar: true,
        },
        quote: {
            class: Quote,
            inlineToolbar: true,
            config: {
                quotePlaceholder: 'Enter a quote',
                captionPlaceholder: 'Quote\'s author',
            },
        },
        delimiter: {
            class: Delimiter,
            inlineToolbar: true,
        },
        warning: {
            class: Warning,
            inlineToolbar: true,
            config: {
                titlePlaceholder: 'Title',
                messagePlaceholder: 'Message',
            },
        },
        checklist: {
            class: Checklist,
            inlineToolbar: true,
        },
    }
});



editor.isReady
    .then(() => {
        if (getUrlParam('note') != null) {
            loadData();
        }
    }
    )
    .catch((reason) => {
        console.log(`Editor.js initialization failed because of ${reason}`)
    }
    )

function showToastErrorSaving() {
    const Toast = Swal.mixin({
        toast: true,
        customClass: {
            popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
            confirmButton: 'bg-[#0F68A9] text-white',
            cancelButton: 'bg-red-500 text-white',
        },
        position: 'top',
        showConfirmButton: false,
        showCancelButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    Toast.fire({
        icon: 'error',
        title: 'Attention !',
        html: `
                    <div class="text-red-500">
                        Une erreur est survenue lors de la sauvegarde de la note,
                        tout nouveau contenu ajouté risque de ne pas être sauvegardé.
                    </div>
                    `
    });
}

function updateLastModification() {
    let timestamp = new Date();
    let months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];
    let formattedDate = "Le " + timestamp.getDate() + " " + months[timestamp.getMonth()] + " " + timestamp.getFullYear() + ", " + timestamp.getHours() + "h" + String(timestamp.getMinutes()).padStart(2, '0');
    document.getElementById('timestampNote').innerText = formattedDate;
}