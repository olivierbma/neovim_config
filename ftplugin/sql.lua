require('lspconfig').sqls.setup {
  settings = {
    sqls = {
      connections = {
        {
          driver = 'sqlite3',
          dataSourceName =
          'host=tch054ora12c.logi.etsmtl.ca port=1521 user=equipe229 password=Yk7mfV4s  dbname=TCH054 sslmode=disable',
        },

      },
    },
  },
}
