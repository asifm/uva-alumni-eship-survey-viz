# Load all required libraries.
gulp = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'

gulp.task 'coffee', ->
	gulp.src 'coffee/*.coffee'
	.pipe coffee().on('error', gutil.log)
    .pipe sourcemaps.write()
	.pipe gulp.dest('js/')

gulp.task 'watch', ->
	gulp.watch 'coffee/*.coffee', ['coffee']

gulp.task 'default', ['coffee']

# Default task call every tasks created so far.
# gulp.task 'default', ['css', 'html', 'svg', 'copy']