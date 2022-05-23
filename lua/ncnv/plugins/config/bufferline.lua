local present, bufferline = pcall(require, 'bufferline')

if not present then
    return
end

bufferline.setup({
    options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
    }
})
