use std log

# Build absblack refind theme by doing:
export def build [
  big: int = 120 # big icons' size
  small: int = 32 # small icons' size
] {
  mkdir absblack/res/
  cp src/theme.conf absblack/theme.conf
  ls src/res/big/*.svg | each { |svg_file|
    let file_name_wo_ext = $svg_file.name | path parse | get stem;
    inkscape --export-png-color-mode=RGBA_8 --export-png-compression=0 -w $big -h $big $"--export-filename=absblack/res/($file_name_wo_ext).png" $svg_file.name
  }
  ls src/res/small/*.svg | each { |svg_file|
    let file_name_wo_ext = $svg_file.name | path parse | get stem;
    inkscape --export-png-color-mode=RGBA_8 --export-png-compression=0 -w $small -h $small $"--export-filename=absblack/res/($file_name_wo_ext).png" $svg_file.name
  }
}

# Clean build artifacts
export def clean [] {
  rm -rf absblack
}

# Install absblack refind theme where refind is installed
export def install [
  --simulate (-s) # do not install just simulate what will happen
] {
  let refind_dir = sudo fd refind -t d /boot
  log info $"Found refind dir at ($refind_dir)"
  let refind_conf = $refind_dir | path join "refind.conf"
  log info $"Found refind.conf at ($refind_conf)"
  let refind_conf_contents = sudo cat $refind_conf
  if ($simulate) {
    log info $"./absblack copied to ($refind_dir)"
    log info $"appended \"include absblack/theme.conf\" to ($refind_conf)"
  } else {
    sudo cp -r absblack $"($refind_dir)/"
    log info $"./absblack copied to ($refind_dir)"
    if not ($refind_conf_contents | str contains 'include absblack/theme.conf') {
      sudo nu -c $"echo \"\ninclude absblack/theme.conf\n\" | save -af ($refind_conf)"
      log info $"appended \"include absblack/theme.conf\" to ($refind_conf)"
    }
  }
}

# Uninstall absblack refind theme
export def uninstall [
  --simulate (-s) # do not uninstall just simulate what will happen
] {
  let refind_dir = sudo fd refind -t d /boot
  log info $"Found refind_dir at ($refind_dir)"
  let refind_conf = $refind_dir | path join "refind.conf"
  log info $"Found refind.conf at ($refind_conf)"
  let refind_conf_contents = sudo cat $refind_conf
  let absblack_dir = $refind_dir | path join "absblack"
  log info $"absblack installed at ($absblack_dir)"
  if ($simulate) {
    log info $"remove dir ($absblack_dir)"
    log info $"stripping \"include absblack/theme.conf\" from ($refind_conf)"
  } else {
    sudo rm -rf $absblack_dir
    log info $"remove dir ($absblack_dir)"
    if not ($refind_conf_contents | str contains 'include absblack/theme.conf') {
      sudo sed -Ei 's#include absblack/theme.conf##g' $refind_conf
      log info $"stripping \"include absblack/theme.conf\" from ($refind_conf)"
    }
  }
}
