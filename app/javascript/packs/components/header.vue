<template>
  <div class="header">
    <header class="navbar navbar-fixed-top navbar-inverse box">
      <div class="container">
        <a href="/" class="brand-logo left">Sample Application</a>
        <nav>
        <ul class="nav navbar-nav navbar-right">
        <li>Home", root_path</li>
        <li>Help", help_path</li>
          <li>Users", users_path</li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              Account <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <li>Profile</li>
              <li>Settings</li>
              <li class="divider"></li>
              <li>
                Log out
              </li>
            </ul>
          </li>
          <li>Log in"</li>
      </ul>
      </nav>
      </div>
    </header>
  </div>
</template>

<style lang="sass">
</style>