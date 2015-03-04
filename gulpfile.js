'use strict';

var coffee = require('gulp-coffee');
var connect = require('gulp-connect');
var del = require('del');
var gulp = require('gulp');
var inject = require('gulp-inject');
var jade = require('gulp-jade');
var runSequence = require('run-sequence');
var stylus = require('gulp-stylus');

var paths = {
  build: '.tmp'
}

gulp.task('bower', function() {
  return gulp.src(
      'bower_components/**',
      {
        base: '.'
      }
    )
    .pipe(gulp.dest(paths.build));
});

gulp.task('build', function(cb) {
  runSequence(
    'clean',
    [
      'bower',
      'copy',
      'html',
      'javascripts',
      'stylesheets'
    ],
    cb
  );
});

gulp.task('clean', function(cb) {
  del(paths.build, cb);
});

gulp.task('copy', function() {
  return gulp.src(
      'app/{fonts,images}/**',
      {
        base: 'app'
      }
    )
    .pipe(gulp.dest(paths.build));
});

gulp.task('default', ['inject']);

gulp.task('html', function() {
  return gulp.src('app/**/*.jade')
    .pipe(
      jade({
        pretty: true
      })
    )
    .pipe(gulp.dest(paths.build))
});

gulp.task('inject', ['build'], function() {
  return gulp.src(
      paths.build + '/*.html',
      {
        base: '.'
      }
    )
    .pipe(
      inject(
        gulp.src(
          paths.build + '/{javascripts,stylesheets}/**',
          {
            read: false
          }
        ),
        {
          relative: true
        }
      )
    )
    .pipe(gulp.dest('.'));
});

gulp.task('javascripts', function() {
  return gulp.src('app/**/*.coffee')
    .pipe(
      coffee({
        bare: true
      })
    )
    .pipe(gulp.dest(paths.build));
});

gulp.task('serve', ['inject'], function() {
  connect.server({
    root: paths.build
  });

  gulp.watch(['app/**', 'bower.json'], ['inject']);
});

gulp.task('stylesheets', function() {
  return gulp.src('app/**/*.styl')
    .pipe(stylus())
    .pipe(gulp.dest(paths.build));
});
