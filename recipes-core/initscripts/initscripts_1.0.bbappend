FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://mountunion.sh \
	file://umountunion.sh \
	file://wifi-fallback.sh \
	file://gen-public-key.sh \
"

do_install_append () {
    install -m 0755 ${WORKDIR}/mountunion.sh ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/umountunion.sh ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/wifi-fallback.sh ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/gen-public-key.sh ${D}${sysconfdir}/init.d

    update-rc.d -r ${D} umountunion.sh start 30 0 1 6 .
    update-rc.d -r ${D} mountunion.sh start 16 2 3 4 5 S .
    # update-rc.d -r ${D} mountunion.sh start 16 S .

    update-rc.d -r ${D} wifi-fallback.sh start 91 3 5 .
    update-rc.d -r ${D} gen-public-key.sh start 95 3 5 .
}
