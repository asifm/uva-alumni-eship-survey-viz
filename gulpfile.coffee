# Load all required libraries.
gulp = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'



gulp.task 'coffee', ->
	gulp.src 'coffee/*.coffee'
	.pipe coffee()
	.pipe gulp.dest 'js'


gulp.task 'watch', ->
	gulp.watch 'coffee'

# Default task call every tasks created so far.
# gulp.task 'default', ['css', 'html', 'svg', 'copy']