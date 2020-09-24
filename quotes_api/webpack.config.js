const path = require('path')

module.exports = {
  entry: {
    quotes: "./src/handlers/quotes/index.ts",
  },
  target: "node",
  // Already provided by the lambda's node environment
  externals: /^aws-sdk/,
  mode: 'production',
  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx'],
    modules: ['node_modules', 'src']
  },
  module: {
    rules: [{
      test: /\.tsx?$/,
      use: 'ts-loader',
      exclude: /node_modules/,
    }]
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'dist'),
    libraryTarget: 'commonjs2'
  }
}