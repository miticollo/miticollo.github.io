# Issues

How to solve it?

## `ld: symbol(s) not found for architecture`

Add `$(BUILD_BASE)/$(MEMO_PREFIX)$(MEMO_SUB_PREFIX)/lib/libiosexec.tbd` to the `$(CC)` invocation.
