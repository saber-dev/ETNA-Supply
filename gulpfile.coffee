gulp        = require 'gulp'
shell       = require 'gulp-shell'
bowerFiles  = require 'main-bower-files'
clean       = require 'del'
uglify      = require 'gulp-uglify'
filter      = require 'gulp-filter'
concat      = require 'gulp-concat'
js_minify   = require 'gulp-ngmin'
preprocess  = require 'gulp-preprocess'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
changed     = require 'gulp-changed'
coffeelint  = require 'gulp-coffeelint'
css_minify  = require 'gulp-minify-css'
ngAnnotate  = require 'gulp-ng-annotate'
html_minify = require 'gulp-minify-html'

js_filter  = filter '**/*.js', { restore: true }
css_filter = filter '**/*.css', { restore: true }

src  = 'src'
dest = 'public'
name = 'base'

gulp.task 'clean', ->
    clean.sync("#{dest}/*")

gulp.task 'components', ->
	gulp.src bowerFiles()
    .pipe js_filter
    .pipe concat "#{name}-components.js"
    .pipe gulp.dest "#{dest}/js"
    .pipe js_filter.restore
    .pipe css_filter
    .pipe concat "#{name}-components.css"
    .pipe gulp.dest "#{dest}/css"
    .pipe css_filter.restore

gulp.task 'coffee', ->
	gulp.src [ "#{src}/bootstrap.coffee", "#{src}/controller/*.coffee", "#{src}/directives/*.coffee", "#{src}/factory/*.coffee"]
		.pipe changed "#{dest}/js", { extention: '.js' }
		.pipe preprocess()
		.pipe coffee({ bare: true }).on('error', gutil.log)
		.pipe concat "#{name}.js"
		.pipe ngAnnotate()
		.pipe gulp.dest "#{dest}/js"

gulp.task 'jqueryJs', ->
  gulp.src "#{src}/js/*.js"
    .pipe concat    "#{name}-animation.js"
    .pipe gulp.dest "#{dest}/js"

gulp.task 'css', ->
  gulp.src "#{src}/css/*.css"
    .pipe changed   "#{dest}/css}"
    .pipe concat    "#{name}-styles.css"
    .pipe gulp.dest "#{dest}/css"


gulp.task 'copy_other', ->
  gulp.src "#{src}/img/cd-arrow.svg"
    .pipe gulp.dest "#{dest}/medias/img"
  gulp.src "#{src}/view/barNav/*"
    .pipe gulp.dest "#{dest}/templates/barNav"

gulp.task 'compress', ['components'], ->
	gulp.src "#{dest}/js/*.js"
		.pipe ngAnnotate({single_quotes:true})
		.pipe gulp.dest("#{dest}/js")
  gulp.src "#{dest}/css/*.css"
    .pipe css_minify({compatibility: 'ie8'})
    .pipe gulp.dest("#{dest}/css")

gulp.task 'minify', ['compress'], ->
  gulp.src "#{dest}/js/*.js"
    .pipe uglify()
    .pipe gulp.dest("#{dest}/js")
  # gulp.src "#{dest}/templates/*.html"
  #   .pipe html_minify()
  #   .pipe gulp.dest "#{dest}/templates"
  # gulp.src "#{dest}/modal/*.html"
  #   .pipe html_minify()
  #   .pipe gulp.dest "#{dest}/modal"

gulp.task 'lint', ->
	gulp.src [ "#{src}**/*.coffee", 'gulpfile.coffee' ]
		.pipe coffeelint()
		.pipe coffeelint.reporter()

gulp.task 'copy', ['components'], ->
  gulp.src "#{src}/index.html"
    .pipe gulp.dest "#{dest}"
  gulp.src "#{src}/view/*.html"
		.pipe gulp.dest "#{dest}/templates/"
  gulp.src "#{src}/modal/*.html"
    .pipe gulp.dest "#{dest}/modal/"
  gulp.src "#{src}/*.xlsx"
    .pipe gulp.dest "#{dest}"
  gulp.src "bower_components/alasql/dist/alasql.min.js"
    .pipe gulp.dest "#{dest}/js"

gulp.task 'copy_json', ->
  gulp.src "Json/*"
    .pipe gulp.dest "#{dest}/Json"

gulp.task 'img_copy', ->
  gulp.src "#{src}/img/**/*"
    .pipe gulp.dest "#{dest}/img/"

gulp.task 'shell_copy', ['common'], ->
  gulp.src "public"
    .pipe shell 'sudo sh copy_shell.sh'

gulp.task 'common',  ['clean', 'copy', 'coffee', 'css', 'copy_other', 'jqueryJs', 'copy_json', 'img_copy']
gulp.task 'default', [ 'shell_copy']
