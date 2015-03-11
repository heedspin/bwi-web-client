'use strict';

var coffee = require('gulp-coffee');
var connect = require('gulp-connect');
var del = require('del');
var gulp = require('gulp');
var gulpIf = require('gulp-if')
var inject = require('gulp-inject');
var jade = require('gulp-jade');
var rev = require('gulp-rev');
var revReplace = require('gulp-rev-replace');
var runSequence = require('run-sequence');
var stylus = require('gulp-stylus');
var uglify = require('gulp-uglify');
var useref = require('gulp-useref');

var paths = {
  build: '.tmp',
  dist: 'dist'
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

gulp.task('build', ['prepare'], function() {
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

gulp.task('clean', function(cb) {
  del([paths.build, paths.dist], cb);
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

gulp.task('default', ['build']);

gulp.task('dist', ['rev:replace'], function() {
  var assets = useref.assets();

  return gulp.src(paths.dist + '/*.html')
    .pipe(assets)
    .pipe(
      gulpIf(
        '*.js',
        uglify({
          mangle: false
        })
      )
    )
    .pipe(rev())
    .pipe(assets.restore())
    .pipe(useref())
    .pipe(revReplace())
    .pipe(gulp.dest(paths.dist));
});

gulp.task('html', function() {
  return gulp.src('app/**/*.jade')
    .pipe(
      jade({
        pretty: true
      })
    )
    .pipe(gulp.dest(paths.build))
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

gulp.task('prepare', function(cb) {
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

gulp.task('rev', ['build'], function() {
  return gulp.src(paths.build + '/{fonts,images,templates}/**')
    .pipe(rev())
    .pipe(gulp.dest(paths.dist))
    .pipe(rev.manifest())
    .pipe(gulp.dest(paths.dist));
});

gulp.task('rev:replace', ['rev'], function() {
  return gulp.src(paths.build + '/**')
    .pipe(
      revReplace({
        manifest: gulp.src(paths.dist + '/rev-manifest.json')
      })
    )
    .pipe(gulp.dest(paths.dist));
});

gulp.task('serve', ['build'], function() {
  connect.server({
    root: paths.build
  });

  gulp.watch(['app/**', 'bower.json'], ['build']);
});

gulp.task('serve:dist', ['dist'], function() {
  connect.server({
    root: paths.dist
  });
});

gulp.task('stylesheets', function() {
  return gulp.src(
      'app/stylesheets/app.styl',
      {
        base: 'app'
      }
    )
    .pipe(stylus())
    .pipe(gulp.dest(paths.build));
});
