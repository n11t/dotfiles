#!/usr/bin/env bash
#
# Install all symlinks

LINKS=`find * -name '*.link'`
for LINK in ${LINKS}; do
    BASENAME=$(basename "${LINK/%.link}")
    if [ -n "${LINK}" ]; then
        TARGET="${HOME}/.${BASENAME}"
        if [ -f "${TARGET}" ] && [ ! -h ${TARGET} ]; then
            echo "File exists. Backup ${TARGET}"
            mv ${TARGET} ${TARGET}.bak
        fi
        if [ -h "${TARGET}" ]; then
            echo "Remove link ${TARGET}"
            rm -f "${TARGET}" || exit 1
        fi
        echo "Link ${LINK} => ~/.${BASENAME}..."
        ln -s "${PWD}/${LINK}" "${TARGET}" || exit 1
    fi
done
