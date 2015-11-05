'use strict'

globalOpt = require '../config.coffee'

pluginName = 'pixel-admin.plugin.less'
cssName = 'pixel-admin.min.css'
appName = 'pixel-admin-app.js'
libName = 'pixel-admin-libs.js'
minName = 'pixel-admin.min.js'

module.exports =
  style:
    name: cssName
    src: [
      "#{globalOpt.pixeladminPath}/libs/bootstrap-3.*/bootstrap.less"
      "#{globalOpt.stylePath}/pixel-admin.less"
      "#{globalOpt.pixeladminPath}/less/themes/themes.less"
      "#{globalOpt.pixeladminPath}/libs/datepicker/*.less"
    ]
    dest: "#{globalOpt.resourcePath}/css/"
  script:
    name: appName
    src:[
      "#{globalOpt.pixeladminPath}/app/*.coffee"

      # PixelAdmin App Components and Plugins
      "#{globalOpt.pixeladminPath}/app/components/*.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/switcher.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/limiter.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/expanding-input.coffee"
      "#{globalOpt.pixeladminPath}/app/plugins/wizard.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/file-input.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/tasks.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/rating.coffee"
      # "#{globalOpt.pixeladminPath}/app/plugins/flot.coffee"

      # PixelAdmin Extensions
      # "#{globalOpt.pixeladminPath}/app/extensions/modal.coffee"
      "#{globalOpt.pixeladminPath}/app/extensions/bootstrap-datepicker.coffee"
      # "#{globalOpt.pixeladminPath}/app/extensions/bootstrap-timepicker.coffee"
      # "#{globalOpt.pixeladminPath}/app/extensions/bootstrap-datepaginator.coffee"
      # "#{globalOpt.pixeladminPath}/app/extensions/bootstrap-tabdrop.coffee"
      # "#{globalOpt.pixeladminPath}/app/extensions/jquery.validate.coffee"
      # "#{globalOpt.pixeladminPath}/app/extensions/jquery.knob.coffee"
      "#{globalOpt.pixeladminPath}/app/extensions/jquery.sparklines.coffee"

      "#{globalOpt.pixeladminPath}/libs/datepicker/simple.datepicker.coffee"
    ]
    dest: "#{globalOpt.tempPath}/"
  lib:
    name: libName
    src: [
      # bootstrap
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/transition.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/alert.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/button.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/carousel.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/collapse.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/dropdown.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/modal.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/tooltip.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/popover.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/scrollspy.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/tab.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-3.1.1/affix.js"

      # Touch devices
      "#{globalOpt.pixeladminPath}/libs/fastclick-0.6.11.js"
      "#{globalOpt.pixeladminPath}/libs/jquery.event.move-1.3.6.js"
      "#{globalOpt.pixeladminPath}/libs/jquery.event.swipe-0.5.js"

      # External plugins
      # "#{globalOpt.pixeladminPath}/libs/jquery.vague-0.0.4.js"
      # "#{globalOpt.pixeladminPath}/libs/select2-3.4.5/select2.js"

      # jQuery UI
      "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.core.js"
      "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.widget.js"
      "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.mouse.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.position.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.sortable.js"

      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.accordion.js"
      "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.menu.js"
      "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.slider.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.autocomplete.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.spinner.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.progressbar.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-ui-1.10.4/jquery.ui.tabs.js"

      # PixelAdmin App Components and Plugins
      "#{globalOpt.pixeladminPath}/libs/pixel-slimscroll.js" # Slimscroll, optimized for the main menu dropdowns / Navbar collapse

      # Plugins
      "#{globalOpt.pixeladminPath}/libs/bootstrap-datepicker-1.3.0/bootstrap-datepicker.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-timepicker-0.2.5.js"

      # "#{globalOpt.pixeladminPath}/libs/bootstrap-tabdrop.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.minicolors-2.1.1.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.maskedinput-1.3.1.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.autosize-1.18.4.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.knob-1.2.7.js"
      "#{globalOpt.pixeladminPath}/libs/jquery.sparkline-2.1.2.js"
      "#{globalOpt.pixeladminPath}/libs/jquery.easypiechart-2.1.5.js"
      "#{globalOpt.pixeladminPath}/libs/jquery.slimscroll-1.3.2.js"

      # "#{globalOpt.pixeladminPath}/libs/moment-2.5.1.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-datepaginator-1.1.0.js"

      # "#{globalOpt.pixeladminPath}/libs/bootstrap-editable-1.5.1/bootstrap-editable.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-editable-1.5.1/inputs-ext/address/address.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/lib/typeahead.js"
      # "#{globalOpt.pixeladminPath}/libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/typeaheadjs.js"

      # "#{globalOpt.pixeladminPath}/libs/jquery.validate-1.11.1/jquery.validate.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.validate-1.11.1/additional-methods.js"

      # "#{globalOpt.pixeladminPath}/libs/jquery-datatables-1.10.0/jquery.datatables.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery-datatables-1.10.0/datatables.bootstrap3.js"

      # "#{globalOpt.pixeladminPath}/libs/dropzone-amd-module-3.8.4.js"
      # "#{globalOpt.pixeladminPath}/libs/dropzone-3.8.4.js"

      # "#{globalOpt.pixeladminPath}/libs/summernote-0.5.1/summernote.js"

      "#{globalOpt.pixeladminPath}/libs/bootstrap-markdown-2.2.1/markdown.js"
      "#{globalOpt.pixeladminPath}/libs/bootstrap-markdown-2.2.1/to-markdown.js"
      "#{globalOpt.pixeladminPath}/libs/bootstrap-markdown-2.2.1/bootstrap-markdown.js"

      # "#{globalOpt.pixeladminPath}/libs/raphael-2.1.2.min.js"
      # "#{globalOpt.pixeladminPath}/libs/morris-0.5.0.js"

      # "#{globalOpt.pixeladminPath}/libs/jquery.flot-0.8.2/jquery.flot.js"
      # "#{globalOpt.pixeladminPath}/libs/jquery.flot-0.8.2/jquery.flot.pie.js"

      "#{globalOpt.pixeladminPath}/libs/datepicker/datepicker.js"
    ]
    dest: "#{globalOpt.tempPath}/"
  build:
    name: minName
    src: [
      "#{globalOpt.tempPath}/#{libName}"
      "#{globalOpt.tempPath}/#{appName}"
    ]
    dest: "#{globalOpt.resourcePath}/js/"
