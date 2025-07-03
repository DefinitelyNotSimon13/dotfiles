vim.lsp.config['tinymist'] = {
  cmd = { 'tinymist' },
  filtypes = { 'typst' },
  settings = {
    projectResolution = 'lockDatabase',
    outputPath = '$root/out/$name',
  },
}
