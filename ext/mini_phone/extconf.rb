# frozen_string_literal: true

# rubocop:disable Style/GlobalVars

require 'mkmf'

conf = RbConfig::MAKEFILE_CONFIG

if conf['target_cpu'] == 'arm64' && conf['target_os'].start_with?('darwin')
  $LIBPATH << '/opt/homebrew/lib'
  $INCFLAGS << ' -I/opt/homebrew/include '
  $CXXFLAGS << ' -I/opt/homebrew/include '
end

unless have_library("phonenumber") && have_library("protobuf")
  abort <<~MSG

    ,----------------------------------------------------------------------,
    |                                                                      |
    | Hey there, sorry for the inconvenience!                              |
    |                                                                      |
    | It looks like libphonenumber and/or protobuf is not installed on     |
    | this system. Don't worry, this should be easy to fix:                |
    |                                                                      |
    | 1. Install the libs                                                  |
    |                                                                      |
    |  On Mac:                                                             |
    |    brew install libphonenumber protobuf                              |
    |                                                                      |
    |  On Debian / Ubuntu:                                                 |
    |    apt-get install -y libphonenumber-dev libprotobuf-dev             |
    |                                                                      |
    | 2. Retry installing the gem (i.e `bundle install`)                   |
    |                                                                      |
    '----------------------------------------------------------------------'

  MSG
end

dir_config('mini_phone')

$CXXFLAGS += ' -std=c++17 -ofast '

create_makefile('mini_phone/mini_phone')

# rubocop:enable Style/GlobalVars
