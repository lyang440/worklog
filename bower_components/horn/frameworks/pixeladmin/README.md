## gulp task

（初步）gulpfile 中 pixeladmin 相关的 task

```coffeescript
### ------------------------------------
pixel admin START
------------------------------------ ###

PIXEL_ADMIN_PATH = "#{BASE_PATH}/pixel-admin"
PIXEL_SCRIPT_SRC = [
  'app/*.coffee'

  # PixelAdmin App Components and Plugins
  'app/components/*.coffee'
  # 'app/plugins/switcher.coffee'
  # 'app/plugins/limiter.coffee'
  # 'app/plugins/expanding-input.coffee'
  # 'app/plugins/wizard.coffee'
  # 'app/plugins/file-input.coffee'
  # 'app/plugins/tasks.coffee'
  # 'app/plugins/rating.coffee'
  # 'app/plugins/flot.coffee'

  # PixelAdmin Extensions
  # 'app/extensions/modal.coffee'
  # 'app/extensions/bootstrap-datepicker.coffee'
  # 'app/extensions/bootstrap-timepicker.coffee'
  # 'app/extensions/bootstrap-datepaginator.coffee'
  # 'app/extensions/bootstrap-tabdrop.coffee'
  # 'app/extensions/jquery.validate.coffee'
  # 'app/extensions/jquery.knob.coffee'
  # 'app/extensions/jquery.sparklines.coffee'
]
PIXEL_LIBS_SRC = [
  # bootstrap
  # 'libs/bootstrap-3.1.1/transition.js'
  # 'libs/bootstrap-3.1.1/alert.js'
  # 'libs/bootstrap-3.1.1/button.js'
  # 'libs/bootstrap-3.1.1/carousel.js'
  # 'libs/bootstrap-3.1.1/collapse.js'
  # 'libs/bootstrap-3.1.1/dropdown.js'
  # 'libs/bootstrap-3.1.1/modal.js'
  # 'libs/bootstrap-3.1.1/tooltip.js'
  # 'libs/bootstrap-3.1.1/popover.js'
  # 'libs/bootstrap-3.1.1/scrollspy.js'
  # 'libs/bootstrap-3.1.1/tab.js'
  # 'libs/bootstrap-3.1.1/affix.js'

  # Touch devices
  # 'libs/fastclick-0.6.11.js'
  # 'libs/jquery.event.move-1.3.6.js'
  # 'libs/jquery.event.swipe-0.5.js'

  # External plugins
  # 'libs/jquery.vague-0.0.4.js'
  # 'libs/select2-3.4.5/select2.js'

  # jQuery UI
  # 'libs/jquery-ui-1.10.4/jquery.ui.core.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.widget.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.mouse.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.position.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.sortable.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.slider.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.accordion.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.menu.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.autocomplete.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.spinner.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.progressbar.js'
  # 'libs/jquery-ui-1.10.4/jquery.ui.tabs.js'

  # PixelAdmin App Components and Plugins
  'libs/pixel-slimscroll.js' # Slimscroll, optimized for the main menu dropdowns / Navbar collapse

  # Plugins
  # 'libs/bootstrap-datepicker-1.3.0/bootstrap-datepicker.js'
  # 'libs/bootstrap-timepicker-0.2.5.js'

  # 'libs/bootstrap-tabdrop.js'
  # 'libs/jquery.minicolors-2.1.1.js'
  # 'libs/jquery.maskedinput-1.3.1.js'
  # 'libs/jquery.autosize-1.18.4.js'
  # 'libs/bootbox.min-4.2.0.js'
  # 'libs/jquery.growl-1.2.5.js'
  # 'libs/jquery.knob-1.2.7.js'
  # 'libs/jquery.sparkline-2.1.2.js'
  # 'libs/jquery.easypiechart-2.1.5.js'
  'libs/jquery.slimscroll-1.3.2.js'

  # 'libs/moment-2.5.1.js'
  # 'libs/moment-with-customlangs.min.js'
  # 'libs/bootstrap-datepaginator-1.1.0.js'

  # 'libs/bootstrap-editable-1.5.1/bootstrap-editable.js'
  # 'libs/bootstrap-editable-1.5.1/inputs-ext/address/address.js'
  # 'libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/lib/typeahead.js'
  # 'libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/typeaheadjs.js'

  # 'libs/jquery.validate-1.11.1/jquery.validate.js'
  # 'libs/jquery.validate-1.11.1/additional-methods.js'

  # 'libs/jquery-datatables-1.10.0/jquery.datatables.js'
  # 'libs/jquery-datatables-1.10.0/datatables.bootstrap3.js'

  # 'libs/dropzone-amd-module-3.8.4.js'
  # 'libs/dropzone-3.8.4.js'

  # 'libs/summernote-0.5.1/summernote.js'

  # 'libs/bootstrap-markdown-2.2.1/markdown.js'
  # 'libs/bootstrap-markdown-2.2.1/to-markdown.js'
  # 'libs/bootstrap-markdown-2.2.1/bootstrap-markdown.js'

  # 'libs/raphael-2.1.2.min.js'
  # 'libs/morris-0.5.0.js'

  # 'libs/jquery.flot-0.8.2/jquery.flot.js'
  # 'libs/jquery.flot-0.8.2/jquery.flot.pie.js'
]
PIXEL_STYLES_SRC = [
  'libs/bootstrap-3.*/bootstrap.less'
  'pixel-admin.less' # 引入 pixel admin 控制插件及theme
]
PIXEL_SCRIPT_DEST_FILE = 'pixel-admin-app.js'
PIXEL_LIBS_DEST_FILE = 'pixel-admin-libs.js'

gulp.task 'pixel-build-js', ->
  gulp.src PIXEL_SCRIPT_SRC, cwd: PIXEL_ADMIN_PATH
    .pipe plumber errorHandler: errHandler
    .pipe coffee coffeeOption
    .pipe concat PIXEL_SCRIPT_DEST_FILE
    .pipe gulp.dest '', cwd: PIXEL_ADMIN_PATH

gulp.task 'pixel-build-css', ->
  gulp.src PIXEL_LIBS_SRC, cwd: PIXEL_ADMIN_PATH
    .pipe plumber errorHandler: errHandler
    .pipe concat PIXEL_LIBS_DEST_FILE
    .pipe gulp.dest '', cwd: PIXEL_ADMIN_PATH

gulp.task 'pixel-admin-build', ->
  gulp.src [
    PIXEL_LIBS_DEST_FILE
    PIXEL_SCRIPT_DEST_FILE
  ], cwd: PIXEL_ADMIN_PATH
    .pipe concat 'pixel-admin.min.js'
    .pipe if IS_PROD then minifier minifierOption else gutil.noop()
    .pipe gulp.dest "#{PUBLIC_PATH}/js/"

  gulp.src PIXEL_STYLES_SRC, cwd: PIXEL_ADMIN_PATH
    .pipe plumber errorHandler: errHandler
    .pipe less()
    .pipe concat 'pixel-admin.min.css'
    .pipe if IS_PROD then minifier minifierOption else gutil.noop()
    .pipe gulp.dest "#{PUBLIC_PATH}/css/"

gulp.task 'pixel-admin', ->
  runSequence 'pixel-build-js', 'pixel-build-css', 'pixel-admin-build'
### ------------------------------------
pixel admin END
------------------------------------ ###
```

## less

可用的less组件，你可以通过以下方式来选择需要的样式

+ 直接修改 pixel-admin.less 中的注释（推荐）
+ 或 在自己的 gulpfile 中 concat
+ 或 自己添加一个 less 引入

```less
// ### Bootstrap's variables andmixins
@import "./libs/bootstrap-3.1.1/variables.less";
@import "./libs/bootstrap-3.1.1/mixins.less";

// ### Font Awesome's stylesheets
@import './libs/font-awesome-4.0.3/less/font-awesome.less';

// ### Animate.css
@import (less) './libs/animate.css';

// ### Pixel Admin's stylesheets
@import './less/variables.less';
@import './less/mixins.less';
@import './less/base.less';
@import './less/main-navbar.less';
@import './less/main-menu.less';
@import './less/navbar.less';
@import './less/buttons.less';
@import './less/progress-bars.less';
@import './less/labels.less';
@import './less/badges.less';
@import './less/breadcrumb.less';
@import './less/alerts.less';
@import './less/tables.less';
@import './less/navs.less';
@import './less/dropdowns.less';
@import './less/button-groups.less';
@import './less/pagination.less';
@import './less/list-groups.less';
@import './less/forms.less';
@import './less/input-groups.less';
@import './less/panels.less';
@import './less/wells.less';
@import './less/popovers.less';
@import './less/tooltips.less';
@import './less/modals.less';
@import './less/accordions.less';
@import './less/notes.less';
@import './less/counters.less';
@import './less/colors.less';
@import './less/stats.less';
@import './less/utils.less';

// @import './less/demo.less';


// jQuery UI
//

// @import './less/plugins/jquery-ui/common.less';
// @import './less/plugins/jquery-ui/sliders.less';
// @import './less/plugins/jquery-ui/accordions.less';
// @import './less/plugins/jquery-ui/autocomplete.less';
// @import './less/plugins/jquery-ui/menus.less';
// @import './less/plugins/jquery-ui/spinners.less';
// @import './less/plugins/jquery-ui/progress-bars.less';
// @import './less/plugins/jquery-ui/tabs.less';
// @import './less/plugins/jquery-ui/datepicker.less';
// @import './less/plugins/jquery-ui/tooltips.less';


// Plugins
//

// @import './less/plugins/pa.switcher.less';
// @import './less/plugins/pa.limiter.less';
// @import './less/plugins/pa.expanding-input.less';
// @import './less/plugins/pa.wizard.less';
// @import './less/plugins/pa.file-input.less';
// @import './less/plugins/jquery.select2.less';
// @import './less/plugins/bootstrap-datepicker.less';
// @import './less/plugins/bootstrap-timepicker.less';
// @import './less/plugins/bootstrap-datepaginator.less';
// @import './less/plugins/bootstrap-tabdrop.less';
// @import './less/plugins/jquery.minicolors.less';
// // {
//   @import './less/plugins/bootstrap-editable/bootstrap-editable.less';
//   @import './less/plugins/bootstrap-editable/address.less';
//   @import './less/plugins/bootstrap-editable/typeahead.less';
// // }
// @import './less/plugins/bootbox.less';
// @import './less/plugins/jquery.datatables.less';
@import './less/plugins/jquery.growl.less';
// @import './less/plugins/dropzone.less';
// @import './less/plugins/summernote.less';
// @import './less/plugins/bootstrap-markdown.less';
// @import './less/plugins/jquery.sparkline.less';
// @import './less/plugins/easy-pie-chart.less';
// @import './less/plugins/morris.less';
// @import './less/plugins/jquery.flot.less';
@import './less/plugins/slim-scroll.less';


// Pages
//

@import './less/pages/signin.less';

//
// Themes
// --------------------------------------------------

@import './less/themes/default/default.less';
// @import './less/themes/asphalt/asphalt.less';
// @import './less/themes/purple-hills/purple-hills.less';
// @import './less/themes/adminflare/adminflare.less';
// @import './less/themes/dust/dust.less';
// @import './less/themes/frost/frost.less';
// @import './less/themes/fresh/fresh.less';
// @import './less/themes/silver/silver.less';
// @import './less/themes/clean/clean.less';
@import './less/themes/white/white.less';
```
