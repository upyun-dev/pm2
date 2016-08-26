#!/usr/bin/env bash

SRC=$(cd $(dirname "$0"); pwd)
source "${SRC}/include.sh"

cd $file_path/wait_app

##### start with sending event and without waiting (fork mode)
$pm2 start http-wait-start.js
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start with sending event and ask to wait (fork mode)
$pm2 start http-wait-start.js --wait-ready
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start without sending event and without waiting (fork mode)
$pm2 start http-wait-start.js
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start without sending event and ask to wait (fork mode)
timeout 5 $pm2 start http-wait-start.js --wait-ready
should 'should not have started apps' 'online' 0
$pm2 delete all

##### start with sending event and without waiting (cluster mode)
$pm2 start http-wait-start.js -i 2
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start with sending event and ask to wait (cluster mode)
$pm2 start http-wait-start.js -i 2 --wait-ready
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start without sending event and without waiting (cluster mode)
$pm2 start http-wait-start.js -i 2
should 'should have started 1 apps' 'online' 1
$pm2 delete all

##### start without sending event and ask to wait (cluster mode)
timeout 5 $pm2 start http-wait-start.js -i 2 --wait-ready
should 'should not have started apps' 'online' 0
$pm2 delete all