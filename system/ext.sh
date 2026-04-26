#!/bin/sh

# I18n support for few extensions
for ext in \
    logomenu@aryan_k \
    appindicatorsupport@rgcjonas.gmail.com \
    caffeine@patapon.info;
do
    echo "Enabling i18n support for $ext GNOME extension";
    find "/usr/share/gnome-shell/extensions/${ext}/po" -name '*.po' -type f -printf "%P\n" | cut -f1 -d . | while read -r locale; do
        mkdir -p /usr/share/gnome-shell/extensions/${ext}/locale/${locale}/LC_MESSAGES;
        msgfmt /usr/share/gnome-shell/extensions/${ext}/po/${locale}.po -o /usr/share/gnome-shell/extensions/${ext}/locale/${locale}/LC_MESSAGES/${ext}.mo;
    done;
    unset -v locale;
    glib-compile-schemas /usr/share/gnome-shell/extensions/$ext/schemas;
done
unset -v ext
