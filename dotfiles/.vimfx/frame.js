vimfx.setHintMatcher(function(id, element, type) {
  if (id === 'normal') {
    // Treat links to the current page or links with titles as clickable
    // elements to get unique hints
    if (type === 'link') {
      if (element.getAttribute('href')[0] === '#' || element.title) {
        return 'clickable';
      }

    // Don't show hints for elements that aren't actually clickable
    } else if (type === 'clickable') {
      if (element.getAttribute('role') === 'option' ||
          element.getAttribute('draggable') === 'false') {
        return null;
      }
    }

  // Fix cleaned links not being treated as links for tab hints
  } else if (id === 'tab' && element.tagName.toLowerCase() === 'a' && !type) {
    return 'link';
  }

  return type;
});
