# (c) 2023 terminus, LLC
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

ifeq ($(OS), Windows_NT)
	RM := cmd /c del /F /Q
	RMPATHFIXUP = $(subst /,\,$(1))
else
	RM := rm -f
	RMPATHFIXUP = $(1)
endif

DHALL_SOURCE = dhall/Field.dhall dhall/FieldType.dhall dhall/FileFormat.dhall \
               dhall/Record.dhall dhall/TwoNinetySeven.dhall \
               dhall/TwoNinetyEight.dhall

all: json package

json: json/TwoNinetySeven.json json/TwoNinetyEight.json

package: dhall/package.dhall

clean:
	$(info $(RMPATHFIXUP))
	-$(RM) $(call RMPATHFIXUP,json/*)
	-$(RM) $(call RMPATHFIXUP,dhall/package.dhall)

json/%.json: dhall/%.dhall
	dhall-to-json --file $< --output $@

dhall/package.dhall: $(DHALL_SOURCE)
	dhall package dhall

.PHONY: all clean json package
