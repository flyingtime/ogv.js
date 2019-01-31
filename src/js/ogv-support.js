//
// -- ogv-support.js
// https://github.com/brion/ogv.js
// Copyright (c) 2013-2019 Brion Vibber
//

(function() {
  "use strict";

  var OGVCompat = require('./OGVCompat.js').default,
    OGVVersion = __OGV_FULL_VERSION__;

  if (window) {
    // 1.0-compat globals
    window.OGVCompat = OGVCompat;
    window.OGVVersion = OGVVersion;
  }

  module.exports = {
    OGVCompat: OGVCompat,
    OGVVersion: OGVVersion
  };

})();
