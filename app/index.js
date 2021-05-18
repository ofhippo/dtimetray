const { menubar } = require('menubar');

const mb = menubar();

mb.on('ready', () => {
    mb.tray.setImage(__dirname + "/icon.png")
    const trayAnimation = setInterval(frame, 864);
})

function frame() {
    const time = new Date()
    var h = time.getHours()
    var m = time.getMinutes()
    var s = time.getSeconds()
    var ms = time.getMilliseconds();
    var ms_today = 3600000*h + 60000*m + 1000*s + ms;
    mb.tray.setTitle(formatTime(Math.round(ms_today / 864)))
}

function formatTime(time) {
    var addColons = function(s){
        h = s.slice(0,2);
        m = s.slice(2,3);
        return [h,m].join(":");
    }
    var dtime = time.toString();
    while (dtime.length < 5){ dtime = "0" + dtime; }
    return addColons(dtime);
}