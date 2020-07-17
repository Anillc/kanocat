module.exports = {
  "transpileDependencies": [
    "vuetify"
  ],

  configureWebpack: {
    module: {
      rules: [
        {
          test: /\.coffee$/,
          use: 'coffee-loader'
        }
      ]
    }
  },

  pluginOptions: {
    i18n: {
      locale: 'zh',
      fallbackLocale: 'zh',
      localeDir: 'locales',
      enableInSFC: false
    }
  }
}
