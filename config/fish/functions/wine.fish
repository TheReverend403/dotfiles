function wine -d 'WINE with OpenGL optimisation environment variables.'
    set -x __GL_THREADED_OPTIMIZATIONS 0
    set -x __GL_SYNC_TO_VBLANK 1
    set -x __GL_YIELD 'NOTHING'
    set -x STAGING_SHARED_MEMORY 1
    command wine $argv
end
