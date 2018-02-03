%% a must be greater than b
PushI 18
PushI 17
DLabel a-value
DataI 0
DLabel b-value
DataI 0
DLabel old-a
DataI 0
DLabel old-b
DataI 0
PushD old-b			%%[…a b &old-b]
Exchange			%%[…a &old-b b]
StoreI				%%[…a]
PushD old-a			%%[…a &old-a]
Exchange			%%[…&old-a a]
StoreI				%%[…]
PushD old-a			%%[…&old-a]
LoadI				%%[…a]
PushD old-b			%%[…a &old-b]
LoadI 				%%[…a b]
Label startLabel	%%[…a b]
Duplicate
JumpFalse falseLabel
PushD b-value		%%[…a b &b-value]
Exchange				%%[…a &b-value b]
StoreI			%%[…a]
PushD a-value		%%[…a &a-value]
Exchange				%%[…&a-value a]
StoreI			%%[…]
PushD a-value		%%[…&a-value]
LoadI			%%[…a]
PushD b-value		%%[…a &b-value]
LoadI			%%[…a b]
Remainder %%[…a%b]
PushD b-value		%%[…a%b &b-value]
LoadI			%%[…a%b b]
Exchange				%%[…b a%b]
PushD b-value		%%[…b a%b &b-value]
Exchange
StoreI 			%%[…b]
PushD a-value		%%[…b &a-value]
Exchange				%%[…&a-value b]
StoreI			%%[…]
PushD a-value		%%[…&a-value]
LoadI			%%[…a]
PushD b-value		%%[…a &b-value]
LoadI			%%[…a b]
Jump startLabel
Label falseLabel
Label joinLabel
Pop				%%[…gcd]
Duplicate		%%[…gcd gcd]
PushD old-a		%%[…gcd gcd &old-a]
LoadI			%%[…gcd gcd old-a]
Exchange		%%[…gcd old-a gcd]
Divide		%%[…gcd new-a]
Exchange	%%[…new-a gcd]
PushD old-b		%%[…new-a gcd &old-b]
LoadI			%%[…new-a gcd old-b]
Exchange	%%[…new-a old-b gcd]
Divide		%%[…new-a new-b]
PStack
Halt