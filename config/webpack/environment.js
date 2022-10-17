const { environment } = require('@rails/webpacker')

environment.loaders.set('hbs', {
  test: /\.hbs$/,
  loader: ['handlebars-loader']
})

module.exports = environment
