name             'dmbserver'
maintainer       'Jet Feng'
maintainer_email 'jet.feng.al@gmail.com'
license          'All rights reserved'
description      'Installs/Configures dmbserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apt"
depends "build-essential"
depends "runit", '>= 1.1.2'
depends "appbox"
depends "rvm"


depends "postgresql"
depends "nvm"

depends "nodejs"
depends "database"

depends "golang"