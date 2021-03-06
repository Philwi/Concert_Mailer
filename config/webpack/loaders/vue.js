const { dev_server: devServer } = require('@rails/webpacker').config

const isProduction = process.env.NODE_ENV === 'production'
const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))
const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction

module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
    options: {
      extractCSS,
      loaders: {
        sass: 'vue-style-loader!css-loader!postcss-loader!sass-loader?indentedSyntax',
        js: 'babel-loader',
        scss: 'vue-style-loader!css-loader!postcss-loader!sass-loader!stylus-loader',
        pug: 'pug-plain-loader'
      }
    }
  }]
}
