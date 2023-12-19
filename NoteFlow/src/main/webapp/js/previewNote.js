function handlePreview(note) {

    if (note.content === "") {
        document.getElementById("notePreview" + note.id).innerHTML = "";
        return;
    }

    note.content = JSON.parse(note.content);
    var preview = document.getElementById("notePreview" + note.id);

    // keep only the first 3 blocks
    note.content = note.content.blocks.slice(0, 3);

    //decode html tag like %3C to <
    //if block.data.text is undefined, check block.data.items, if it is undefined, check block.data.content
    note.content.forEach(block => {
        if (block.data.text) {
            block.data.text = decodeURIComponent(block.data.text);
            block.data.text = block.data.text.replace(/class=\\"([^\\"]*)\\"/g, "class='$1'");
        } else if (block.data.items) {
            block.data.items.forEach(item => {
                item.content = decodeURIComponent(item.content);
                item.content = item.content.replace(/class=\\"([^\\"]*)\\"/g, "class='$1'");
            });
        } else if (block.data.content) {
            block.data.content.forEach((row, rowIndex) => {
                row.forEach((cell, cellIndex) => {
                    block.data.content[rowIndex][cellIndex] = decodeURIComponent(cell);
                    block.data.content[rowIndex][cellIndex] = block.data.content[rowIndex][cellIndex].replace(/class=\\\"([^\\"]*)\\\"/g, "class='$1'");
                });
            });
        }else if(block.data.message || block.data.title){
			block.data.message = decodeURIComponent(block.data.message);
			block.data.message = block.data.message.replace(/class=\\"([^\\"]*)\\"/g, "class='$1'");
			block.data.title = decodeURIComponent(block.data.title);
			block.data.title = block.data.title.replace(/class=\\"([^\\"]*)\\"/g, "class='$1'");
		}
    });

    html = "";

    note.content.forEach(block => {
        switch (block.type) {
            case "header":
                html += createHeader(block.data);
                break;
            case "paragraph":
                html += createParagraph(block.data);
                break;
            case "list":
                html += createList(block.data);
                break;
            case "table":
                html += createTable(block.data);
                break;
            case "quote":
                html += createQuote(block.data);
                break;
            case "code":
                html += createCode(block.data);
                break;
            case "delimiter":
                html += createDelimiter();
                break;
            case "marker":
                html += createMarker(block.data);
                break;
            case "warning":
                html += createWarning(block.data);
                break;
            case "checklist":
                html += createChecklist(block.data);
                break;
            default:
                break;
        }
    });

    preview.innerHTML = html;

}

function createHeader(data) {
    return `<h${data.level} class="!my-0">${data.text}</h${data.level}>`;
}

function createParagraph(data) {
    return `
    <div class="break-words">
        ${data.text}
    </div>`;
}

function createList(data) {
    var html = `<ul class="${data.style === "ordered" ? "list-decimal" : "list-disc"} p-auto">`;
    data.items.forEach(item => {
        html += `<li>${item.content}</li>`;
    });
    html += `</ul>`;
    return html;
}

function createTable(data) {
    var html = `<table class="w-full border-collapse">`;
    data.content.forEach(row => {
        html += `<tr>`;
        row.forEach(cell => {
            html += `<td class="first:border-l-0 last:border-r-0 py-1 border border-black dark:border-white text-black dark:text-white transition-all duration-500 w-[33%] break-all leading-[30px] px-2 align-baseline">
                ${cell}
            </td>`;
        });
        html += `</tr>`;
    });
    html += `</table>`;
    return html;
}

function createQuote(data) {
    return `
        <div class="flex flex-col gap-2">
            <div class="min-h-[156px] bg-transparent text-black dark:text-white border border-gray-300 rounded-md p-2 text-sm transition-all duration-500">
                ${data.text}
            </div>
            <div class="min-h-[44px] bg-transparent text-black dark:text-white border border-gray-300 rounded-md p-2 text-sm transition-all duration-500">
                ${data.caption}
            </div>
        </div>
    `;
}

function createCode(data) {
    return `
                <div class="bg-white dark:bg-gray-800 border border-gray-300 rounded-md p-2 text-sm text-black dark:text-white min-h-[200px] transition-all duration-500">
                    ${data.code}
                </div>
            `;
}

function createDelimiter() {
    return `<div class="my-3 flex justify-center items-center text-xl font-semibold">
        <span>
            * * *
        </span>
    </div>`;
}

function createMarker(data) {
    return `<mark>${data.text}</mark>`;
}

function createWarning(data) {
    return `
        <div class="flex gap-2 w-full">
            <svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg' class="mt-3 dark:invert transition-all duration-500 hidden md:block">
                <rect x='5' y='5' width='14' height='14' rx='4' stroke='black' stroke-width='2'/>
                <line x1='12' y1='9' x2='12' y2='12' stroke='black' stroke-width='2' stroke-linecap='round'/>
                <path d='M12 15.02V15.01' stroke='black' stroke-width='2' stroke-linecap='round'/>
            </svg>
            <div class="flex flex-col gap-1 w-full">
                <div class="min-h-[44px] bg-transparent text-black dark:text-white border border-gray-300 rounded-md p-2 text-sm transition-all duration-500">
                    ${data.title}
                </div>
                <div class="min-h-[83px] bg-transparent text-black dark:text-white border border-gray-300 rounded-md p-2 text-sm transition-all duration-500">
                    ${data.message}
                </div>
            </div>
        </div>
    `;
}

function createChecklist(data) {
    html = "<div class='flex flex-col gap-2 w-full'>";
    data.items.forEach(item => {
        html += `
                <div class="flex gap-3 w-full">
                    <div class="mt-[0.3rem] block w-4 h-4 rounded-[0.25rem] border-2 ${item.checked ? 'bg-[#369FFF] border-[#369FFF]' : 'bg-white border-gray-300'} relative">
                        ${item.checked ? `
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="absolute bottom-[-2px] right-[-2px] bi bi-check" viewBox="0 0 16 16">
                                <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
                            </svg>
                        ` : ''}
                    </div>
                    <div class="text-black dark:text-white transition-all duration-500">
                        ${item.text}
                    </div>
                </div>
            `;
    });
    html += "</div>";
    return html;
}
