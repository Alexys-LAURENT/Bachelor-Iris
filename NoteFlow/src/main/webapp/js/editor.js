

const editor = new EditorJS({
    holder: 'editorjs',
    tools: {
        header: {
            class: Header,
            inlineToolbar: ['link']
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
            shortcut: 'CMD+SHIFT+M',
        },
        list: {
            class: NestedList,
            inlineToolbar: true,
        },
        code: {
            class: CodeTool,
            shortcut: 'CMD+SHIFT+C',
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
    }
});

