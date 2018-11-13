// Hints
Hints.characters = 'sadfjklewcmpgh';
Hints.style('font-family: sans-serif;');
Hints.style('font-family: sans-serif;', 'text');
settings.hintAlign = 'left';

// Tabs
settings.showTabIndices = true;  // Add tab indices to tab titles
settings.tabsThreshold = 0;  // Always use omnibar for choosing tabs

// Input focus
settings.enableAutoFocus = false;  // Don't focus on new inputs
settings.focusOnSaved = false;  // Don't focus on inputs after quitting editor

// Other
settings.modeAfterYank = 'Normal';  // Don't stay in visual mode after yanking
settings.richHintsForKeystroke = 0;  // Disable rich hints for mappings
iunmap(':');  // Disable emoji completion

// Opening links
map('F', 'C');

// Tabs
map('J', 'E');
map('K', 'R');
map('t', 'on');

// History navigation
map('H', 'S');
map('L', 'D');

// Clipboard
map('yf', 'ya');

mapkey('e', '#1Focus on a link or display an element\'s title', () => {
  Hints.create('a, *[title]', element => {
    if (element.href) {
      element.blur();
      element.focus();
    } else {
      alert(decodeURIComponent(element.title));
    }
  });
});

mapkey('E', '#1Open a link in a new private window', () => {
  Hints.create('a', element => {
    RUNTIME('openIncognito', {url: element.href});
  });
});

mapkey('U', '#4Edit current URL with vim editor in current tab', () => {
  Front.showEditor(window.location.href, data => {
    if (window.location.href !== data) {
      window.location.href = data;
    }
  }, 'url');
});

mapkey('R', '#4Reload the page without cache', () => {
  window.location.reload(true);
});

mapkey('p', '#7Open and edit link from clipboard in current tab', () => {
  Clipboard.read(response => {
    Front.showEditor(response.data, data => {
      window.location.href = data;
    }, 'url');
  });
});

mapkey('P', '#7Open and edit link from clipboard in new tab', () => {
  Clipboard.read(response => {
    Front.showEditor(response.data, data => {
      tabOpenLink(data);
    }, 'url');
  });
});

mapkey('oi', '#8Open private window', () => {
  RUNTIME('openIncognito');
});
