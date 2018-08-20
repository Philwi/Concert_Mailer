const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

{
  module: {
    rules: [
      {
        test: /\.pug$/,
        loader: 'pug-plain-loader'
      }
    ]
  }
}

environment.loaders.append('vue', vue)
module.exports = environment

