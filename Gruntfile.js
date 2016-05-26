module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    // read Package.json
    pkg: grunt.file.readJSON('package.json'),

    // browserify
    browserify: {
      core: {
        options: {
          browserifyOptions: {
            standalone: 'travisTester'
          }
        },
        src: './index.js',
        dest: 'build/travisTester.js',
      },
    },

    // Uglify
    uglify: {
      core: {
        options: {
        },
        files: {
          './build/travisTester.min.js': ['./build/travisTester.js'],
        }
      }
    },

    // Watch
    watch: {
      scripts: {
        files: ['./index.js', 'Gruntfile.js', './src/**/*.js'],
        tasks: ['build'],
        options: {
          spawn: false,
        },
      },
    },

    // jshint
    jshint: {
      options: {
        loopfunc: true
      },
      all: {
        src: ['./index.js', './src/**/*.js'],
      },
    },

  });

  // Load the plugins
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');

  // task(s).
  grunt.registerTask('build', ['jshint', 'browserify', 'uglify']);
  grunt.registerTask('dev-server', ['build', 'watch']);

};
