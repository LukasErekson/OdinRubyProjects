'use strict';
window.onload = (event) => {
  
  let nav_links = document.getElementsByClassName('nav-link');

  for (let i = 0; i < nav_links.length; i++) {
    nav_links[i].addEventListener('click', make_active);
  }

  /**Removes the active class from all the nav-links and adds
     the active class to the section clicked last.
   
     @param[Event] event The click event, used to identify the
                         active target.
  */
  function make_active(event) {
    for (let i = 0; i < nav_links.length; i++) {
      nav_links[i].classList.remove('active');
    }
    event.target.classList.add('active');
  }
    
  
}