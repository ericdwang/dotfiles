const options = {
  'custom.mode.normal.focus_location_bar_end': 'O',
  'custom.mode.normal.focus_location_bar_private': 'gP',
  'custom.mode.normal.follow_in_private_tab': 'C',
  'custom.mode.normal.tab_new_private': 'T',
  'focus_next_key': '',
  'focus_previous_key': '',
  'mode.normal.element_text_select': 'V',
  'mode.normal.enter_mode_ignore': 'gi',
  'mode.normal.focus_search_bar': '',
  'mode.normal.focus_text_input': 'i',
  'mode.normal.follow_focus': 'c',
  'mode.normal.tab_new_after_current': '',
  'mode.normal.tab_select_first': 'b',
  'prevent_autofocus': true,
};

for (key in options) {
  vimfx.set(key, options[key]);
}

const commands = vimfx.modes.normal.commands;

vimfx.addCommand({
  name: 'focus_location_bar_end',
  category: 'location',
  description: 'Focus the location bar with the cursor at the end',
  order: commands.focus_location_bar.order + 1,
}, function({vim}) {
  var urlbar = vim.window.document.getElementById('urlbar');
  urlbar.focus();

  // Clear the current value and re-add it to place the cursor at the end
  var url = urlbar.value;
  urlbar.value = '';
  urlbar.value = url;
});

vimfx.addCommand({
  name: 'focus_location_bar_private',
  category: 'location',
  description: 'Focus the location bar in a private tab',
  order: commands.focus_location_bar_end.order + 1,
}, function(args) {
  args.vim.window.gBrowser.loadURI('private:about:blank');
  commands.focus_location_bar.run(args);
});

vimfx.addCommand({
  name: 'tab_new_private',
  category: 'tabs',
  description: 'New private tab',
  order: commands.tab_new.order + 1,
}, function(args) {
  args.vim.window.gBrowser.loadOneTab(
    'private:about:blank', {inBackground: false});
  commands.focus_location_bar.run(args);
});

vimfx.addCommand({
  name: 'follow_in_private_tab',
  category: 'browsing',
  description: 'Follow link in a new private tab',
  order: commands.follow_in_tab.order + 1,
}, function(args) {
  commands.follow_in_tab.run(Object.assign({}, args, {
    callbackOverride({href}) {
      args.vim.window.gBrowser.loadOneTab(
        'private:' + href, {relatedToCurrent: true});
      return false;
    },
  }));
});
