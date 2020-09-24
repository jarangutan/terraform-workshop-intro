
const { series, task } = require('gulp')
const shell = require('gulp-shell')
const minimist = require('minimist')

const knownOptions = {
  string: ['env', 'alias'],
  default: { env: process.env.ENV || 'dev', alias: process.env.ENV || 'dev' }
}

// get environment and set working directory
const options = minimist(process.argv.slice(2), knownOptions)
const env = options.env
const alias = options.alias
process.chdir('./terraform/')

const tfvarFilePath = 'config/' + env + '.tfvars'

task('terraform', series(
  shell.task([
    'terraform fmt',
    'terraform workspace select ' + alias,
    'terraform validate',
    'terraform apply -var-file="' + tfvarFilePath + '"'
  ]))
)

task('terraform-init', series(
  shell.task([
    'terraform init',
    'terraform workspace new ' + alias
  ]))
)

exports.build = task('infra',
  series(
    task('terraform')
  ))

exports.build = task('init',
  series(
    task('terraform-init')
  ))