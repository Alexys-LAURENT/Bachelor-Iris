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


            editor.render(JSON.parse(JSON.parse(decodedData)));
        }
    });
}



const editor = new EditorJS({
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
                    content: JSON.stringify(encodedData),
                    idNote: getUrlParam('note'),
                }
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