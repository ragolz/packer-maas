define check_packages_deps
_current_deps := libnbd-bin nbdkit packer fuse2fs $(1)
_focal_deps := libnbd0 nbdfuse nbdkit packer fuse2fs $(2)

print-deps:
	@if [ $(shell lsb_release -sr|cut -d. -f1) -ge 22 ];then \
		echo $$(_current_deps); \
	elif [ $(shell lsb_release -a | grep "Distributor ID" | cut -d: -f2| xargs) = "Debian" ] && [ $(shell lsb_release -sr|cut -d. -f1) -ge 12 ]; then \
		echo $$(_current_deps); \
	else \
		echo $$(_focal_deps); \
	fi

check-deps:
	@if [ $(shell lsb_release -sr|cut -d. -f1) -ge 22 ];then \
		dpkg -s $$(_current_deps) > /dev/null; \
	elif [ $(shell lsb_release -a | grep "Distributor ID" | cut -d: -f2| xargs) = "Debian" ] && [ $(shell lsb_release -sr|cut -d. -f1) -ge 12 ]; then \
		echo $$(_current_deps); \
	else \
		dpkg -s $$(_focal_deps) > /dev/null; \
	fi
endef
