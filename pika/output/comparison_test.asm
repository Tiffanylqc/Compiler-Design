        Label        -mem-manager-initialize   
        DLabel       $heap-start-ptr           
        DataZ        4                         
        DLabel       $heap-after-ptr           
        DataZ        4                         
        DLabel       $heap-first-free          
        DataZ        4                         
        DLabel       $mmgr-newblock-block      
        DataZ        4                         
        DLabel       $mmgr-newblock-size       
        DataZ        4                         
        PushD        $heap-memory              
        Duplicate                              
        PushD        $heap-start-ptr           
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Jump         $$main                    
        DLabel       $eat-location-zero        
        DataZ        8                         
        DLabel       $print-format-integer     
        DataC        37                        %% "%d"
        DataC        100                       
        DataC        0                         
        DLabel       $print-format-floating    
        DataC        37                        %% "%g"
        DataC        103                       
        DataC        0                         
        DLabel       $print-format-boolean     
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-character   
        DataC        37                        %% "%c"
        DataC        99                        
        DataC        0                         
        DLabel       $print-format-string      
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-tab         
        DataC        9                         %% "\t"
        DataC        0                         
        DLabel       $print-format-newline     
        DataC        10                        %% "\n"
        DataC        0                         
        DLabel       $print-format-space       
        DataC        32                        %% " "
        DataC        0                         
        DLabel       $boolean-true-string      
        DataC        116                       %% "true"
        DataC        114                       
        DataC        117                       
        DataC        101                       
        DataC        0                         
        DLabel       $boolean-false-string     
        DataC        102                       %% "false"
        DataC        97                        
        DataC        108                       
        DataC        115                       
        DataC        101                       
        DataC        0                         
        DLabel       $dash-string              
        DataC        95                        %% "_"
        DataC        0                         
        DLabel       $divide-sign-string       
        DataC        47                        %% "/"
        DataC        0                         
        DLabel       $minus-sign-string        
        DataC        45                        %% "-"
        DataC        0                         
        DLabel       $open-bracket-string      
        DataC        91                        %% "["
        DataC        0                         
        DLabel       $close-bracket-string     
        DataC        93                        %% "]"
        DataC        0                         
        DLabel       $comma-string             
        DataC        44                        %% ","
        DataC        0                         
        DLabel       $errors-general-message   
        DataC        82                        %% "Runtime error: %s\n"
        DataC        117                       
        DataC        110                       
        DataC        116                       
        DataC        105                       
        DataC        109                       
        DataC        101                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        58                        
        DataC        32                        
        DataC        37                        
        DataC        115                       
        DataC        10                        
        DataC        0                         
        Label        $$general-runtime-error   
        PushD        $errors-general-message   
        Printf                                 
        Halt                                   
        DLabel       $errors-int-divide-by-zero 
        DataC        105                       %% "integer divide by zero"
        DataC        110                       
        DataC        116                       
        DataC        101                       
        DataC        103                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$i-divide-by-zero        
        PushD        $errors-int-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $errors-float-divide-by-zero 
        DataC        102                       %% "float divide by zero"
        DataC        108                       
        DataC        111                       
        DataC        97                        
        DataC        116                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$f-divide-by-zero        
        PushD        $errors-float-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $null-array-runtime-error 
        DataC        110                       %% "null array"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        0                         
        Label        $$null-array              
        PushD        $null-array-runtime-error 
        Jump         $$general-runtime-error   
        DLabel       $index-out-of-bound-error 
        DataC        97                        %% "array index out of bound"
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        111                       
        DataC        117                       
        DataC        116                       
        DataC        32                        
        DataC        111                       
        DataC        102                       
        DataC        32                        
        DataC        98                        
        DataC        111                       
        DataC        117                       
        DataC        110                       
        DataC        100                       
        DataC        0                         
        Label        $$index-out-of-bound      
        PushD        $index-out-of-bound-error 
        Jump         $$general-runtime-error   
        DLabel       $zero-denominator-error   
        DataC        111                       %% "over zero denominator"
        DataC        118                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        32                        
        DataC        100                       
        DataC        101                       
        DataC        110                       
        DataC        111                       
        DataC        109                       
        DataC        105                       
        DataC        110                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $$over-zero-denominator   
        PushD        $zero-denominator-error   
        Jump         $$general-runtime-error   
        DLabel       $expressover-divide-by-zero 
        DataC        101                       %% "expressover divide by zero"
        DataC        120                       
        DataC        112                       
        DataC        114                       
        DataC        101                       
        DataC        115                       
        DataC        115                       
        DataC        111                       
        DataC        118                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$rational-expressover-divide-by-zero 
        PushD        $expressover-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $rationalize-divide-by-zero 
        DataC        114                       %% "rationalize divide by zero"
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        111                       
        DataC        110                       
        DataC        97                        
        DataC        108                       
        DataC        105                       
        DataC        122                       
        DataC        101                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$rationalize-divide-by-zero 
        PushD        $rationalize-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $negative-array-length    
        DataC        110                       %% "negative array length"
        DataC        101                       
        DataC        103                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        0                         
        Label        $$negative-length-array   
        PushD        $negative-array-length    
        Jump         $$general-runtime-error   
        DLabel       $a-indexing-array         
        DataZ        4                         
        DLabel       $a-indexing-index         
        DataZ        4                         
        DLabel       $express-over-denominator 
        DataZ        4                         
        DLabel       $rational-denominator-temp 
        DataZ        4                         
        DLabel       $rational-numerator-temp  
        DataZ        4                         
        DLabel       $rational-denominator-temp2 
        DataZ        4                         
        DLabel       $rational-numerator-temp2 
        DataZ        4                         
        DLabel       $rational-print-integer-part 
        DataZ        4                         
        DLabel       $rational-print-remainder 
        DataZ        4                         
        DLabel       $rational-print-sign      
        DataZ        4                         
        DLabel       $record-creation-temp     
        DataZ        4                         
        DLabel       $array-datasize-temp      
        DataZ        4                         
        DLabel       $array-identifier-temp    
        DataZ        4                         
        DLabel       $array-status-temp        
        DataZ        4                         
        DLabel       $array-subtype-size-temp  
        DataZ        4                         
        DLabel       $array-length-temp        
        DataZ        4                         
        DLabel       $array-element-temp       
        DataZ        4                         
        DLabel       $cloned-array-temp        
        DataZ        4                         
        DLabel       $print-string-temp        
        DataZ        4                         
        DLabel       $print-string-length      
        DataZ        4                         
        Label        $lowest-term-subroutine   
        DLabel       $lowest-term-return       
        DataZ        4                         
        PushD        $lowest-term-return       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        DLabel       $lowest-term-denominator  
        DataZ        4                         
        DLabel       $lowest-term-numerator    
        DataZ        4                         
        DLabel       $lowest-term-gcd          
        DataZ        4                         
        DLabel       $lowest-term-tmpa         
        DataZ        4                         
        DLabel       $lowest-term-tmpb         
        DataZ        4                         
        PushD        $lowest-term-denominator  
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Subtract                               
        JumpNeg      -lowest-term-subroutine-1-exchange 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Jump         -lowest-term-subroutine-1-loop-start 
        Label        -lowest-term-subroutine-1-exchange 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-numerator    
        LoadI                                  
        Label        -lowest-term-subroutine-1-loop-start 
        PushD        $lowest-term-tmpb         
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-tmpa         
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-tmpa         
        LoadI                                  
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Duplicate                              
        JumpFalse    -lowest-term-subroutine-1-end 
        Remainder                              
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Exchange                               
        Jump         -lowest-term-subroutine-1-loop-start 
        Label        -lowest-term-subroutine-1-end 
        Pop                                    
        PushD        $lowest-term-gcd          
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-gcd          
        LoadI                                  
        Divide                                 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-gcd          
        LoadI                                  
        Divide                                 
        PushD        $lowest-term-return       
        LoadI                                  
        Return                                 
        Label        $clear-n-bytes-subroutine 
        DLabel       $clear-n-bytes-return-address 
        DataZ        4                         
        PushD        $clear-n-bytes-return-address 
        Exchange                               
        StoreI                                 
        DLabel       $clear-n-bytes-element-size 
        DataZ        4                         
        PushD        $clear-n-bytes-element-size 
        Exchange                               
        StoreI                                 
        DLabel       $clear-n-bytes-element-addr 
        DataZ        4                         
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreI                                 
        Label        -clear-n-bytes-subroutine-2-loop-start 
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        JumpFalse    -clear-n-bytes-subroutine-2-end 
        PushI        0                         
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $clear-n-bytes-element-addr 
        LoadI                                  
        Add                                    
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        Add                                    
        PushD        $clear-n-bytes-element-size 
        Exchange                               
        StoreI                                 
        Jump         -clear-n-bytes-subroutine-2-loop-start 
        Label        -clear-n-bytes-subroutine-2-end 
        PushD        $clear-n-bytes-return-address 
        LoadI                                  
        Return                                 
        Label        $print-array-subroutine   
        DLabel       -print-array-recursive-3-return-address 
        DataZ        4                         
        PushD        -print-array-recursive-3-return-address 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-3-type 
        DataZ        4                         
        PushD        -print-array-recursive-3-type 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-3-element 
        DataZ        4                         
        DLabel       -print-array-recursive-3-length 
        DataZ        4                         
        DLabel       -print-array-recursive-3-elem-size 
        DataZ        4                         
        Duplicate                              
        Duplicate                              
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -print-array-recursive-3-element 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-3-length 
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-3-elem-size 
        Exchange                               
        StoreI                                 
        PushD        $open-bracket-string      
        PushD        $print-format-string      
        Printf                                 
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        2                         
        BTAnd                                  
        JumpFalse    -print-array-recursive-3-one-dim 
        Label        -print-array-recursive-3-loop-start 
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-3-end 
        PushD        -print-array-recursive-3-return-address 
        LoadI                                  
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushD        -print-array-recursive-3-element 
        LoadI                                  
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        PushD        -print-array-recursive-3-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-3-element 
        LoadI                                  
        LoadI                                  
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        Call         $print-array-subroutine   
        PushD        -print-array-recursive-3-elem-size 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-element 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-type 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-return-address 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-3-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-3-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-3-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-loop-start 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-3-loop-start 
        Label        -print-array-recursive-3-one-dim 
        Label        -print-array-recursive-3-loop-start-2 
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-3-end 
        PushD        -print-array-recursive-3-element 
        LoadI                                  
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-int-label 
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        2                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-float-label 
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        3                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-char-label 
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-string-label 
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        5                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-rat-label 
        PushD        -print-array-recursive-3-type 
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-bool-label 
        Label        -print-array-recursive-3-int-label 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-float-label 
        LoadF                                  
        PushD        $print-format-floating    
        Printf                                 
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-char-label 
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-rat-label 
        Duplicate                              
        LoadI                                  
        Exchange                               
        PushI        4                         
        Add                                    
        LoadI                                  
        Call         $print-rational           
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-bool-label 
        LoadC                                  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-string-label 
        LoadI                                  
        Call         $print-string             
        Jump         -print-array-recursive-3-join-label 
        Label        -print-array-recursive-3-join-label 
        PushD        -print-array-recursive-3-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-3-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-3-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-3-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-3-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-3-loop-start-2 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-3-loop-start-2 
        Label        -print-array-recursive-3-end 
        PushD        $close-bracket-string     
        PushD        $print-format-string      
        Printf                                 
        PushD        -print-array-recursive-3-return-address 
        LoadI                                  
        Return                                 
        Label        $print-rational           
        DLabel       $print-rational-return-address 
        DataZ        4                         
        PushD        $print-rational-return-address 
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-4-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-4-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-4-zero-numerator 
        JumpPos      -print-rational-4-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-4-numerator-pos 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $rational-denominator-temp 
        LoadI                                  
        Remainder                              
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $rational-print-integer-part 
        Exchange                               
        StoreI                                 
        PushD        $rational-print-remainder 
        Exchange                               
        StoreI                                 
        PushD        $rational-print-remainder 
        LoadI                                  
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $rational-print-sign      
        LoadI                                  
        JumpPos      -print-rational-4-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-4-rational-pos 
        JumpFalse    -print-rational-4-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-4-fraction 
        JumpFalse    -print-rational-4-end     
        PushD        $dash-string              
        PushD        $print-format-string      
        Printf                                 
        PushD        $rational-print-remainder 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $divide-sign-string       
        PushD        $print-format-string      
        Printf                                 
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-rational-4-end     
        Label        -print-rational-4-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-4-end     
        PushD        $print-rational-return-address 
        LoadI                                  
        Return                                 
        Label        $print-string             
        DLabel       $print-string-return-address 
        DataZ        4                         
        PushD        $print-string-return-address 
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        12                        
        Add                                    
        PushD        $print-string-temp        
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $print-string-length      
        Exchange                               
        StoreI                                 
        Label        -print-string-5-loop-start 
        PushD        $print-string-length      
        LoadI                                  
        JumpFalse    -print-string-5-end       
        PushD        $print-string-temp        
        LoadI                                  
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        PushI        1                         
        PushD        $print-string-temp        
        LoadI                                  
        Add                                    
        PushD        $print-string-temp        
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $print-string-length      
        LoadI                                  
        Add                                    
        PushD        $print-string-length      
        Exchange                               
        StoreI                                 
        Jump         -print-string-5-loop-start 
        Label        -print-string-5-end       
        PushD        $print-string-return-address 
        LoadI                                  
        Return                                 
        Label        $convert-to-string-if-bool-subroutine 
        DLabel       $convert-to-string-if-bool-return-address 
        DataZ        4                         
        PushD        $convert-to-string-if-bool-return-address 
        Exchange                               
        StoreI                                 
        JumpTrue     -print-boolean-6-true     
        PushD        $boolean-false-string     
        Jump         -print-boolean-6-join     
        Label        -print-boolean-6-true     
        PushD        $boolean-true-string      
        Label        -print-boolean-6-join     
        PushD        $convert-to-string-if-bool-return-address 
        LoadI                                  
        Return                                 
        DLabel       -release-record-7-length  
        DataZ        4                         
        DLabel       -release-record-7-element-size 
        DataZ        4                         
        DLabel       -release-record-7-element 
        DataZ        4                         
        Label        $release-record           
        DLabel       $release-record-return-address 
        DataZ        4                         
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        Duplicate                              
        PushI        4                         
        BTAnd                                  
        JumpTrue     -release-record-7-end     
        PushI        8                         
        BTAnd                                  
        JumpTrue     -release-record-7-end     
        PushI        2                         
        BTAnd                                  
        JumpFalse    -release-record-7-release 
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -release-record-7-string-record 
        Duplicate                              
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -release-record-7-length  
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-7-element-size 
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        -release-record-7-element 
        Exchange                               
        StoreI                                 
        Jump         -release-record-7-join    
        Label        -release-record-7-string-record 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-7-length  
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        -release-record-7-element-size 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        PushD        -release-record-7-element 
        Exchange                               
        StoreI                                 
        Label        -release-record-7-join    
        Label        -release-record-7-loop-start 
        PushD        -release-record-7-length  
        LoadI                                  
        JumpFalse    -release-record-7-end     
        PushD        -release-record-7-element 
        LoadI                                  
        PushD        -release-record-7-length  
        LoadI                                  
        PushD        -release-record-7-element-size 
        LoadI                                  
        PushD        $release-record-return-address 
        LoadI                                  
        PushD        -release-record-7-element 
        LoadI                                  
        LoadI                                  
        Call         $release-record           
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        PushD        -release-record-7-element-size 
        Exchange                               
        StoreI                                 
        PushD        -release-record-7-length  
        Exchange                               
        StoreI                                 
        PushD        -release-record-7-element 
        Exchange                               
        StoreI                                 
        PushD        -release-record-7-element-size 
        LoadI                                  
        PushD        -release-record-7-element 
        LoadI                                  
        Add                                    
        PushD        -release-record-7-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -release-record-7-length  
        LoadI                                  
        Add                                    
        PushD        -release-record-7-length  
        Exchange                               
        StoreI                                 
        Jump         -release-record-7-loop-start 
        Label        -release-record-7-release 
        Duplicate                              
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        Call         -mem-manager-deallocate   
        Label        -release-record-7-end     
        PushD        $release-record-return-address 
        LoadI                                  
        Return                                 
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        12                        
        Label        $$main                    
        Label        -compare-equal-8-arg1     
        PushI        2                         
        Label        -compare-equal-8-arg2     
        PushI        2                         
        Label        -compare-equal-8-sub      
        Subtract                               
        JumpFalse    -compare-equal-8-true     
        Jump         -compare-equal-8-false    
        Label        -compare-equal-8-true     
        PushI        1                         
        Jump         -compare-equal-8-join     
        Label        -compare-equal-8-false    
        PushI        0                         
        Jump         -compare-equal-8-join     
        Label        -compare-equal-8-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-9-arg1 
        PushI        2                         
        Label        -compare-lessequal-9-arg2 
        PushI        2                         
        Label        -compare-lessequal-9-sub  
        Subtract                               
        JumpPos      -compare-lessequal-9-false 
        Jump         -compare-lessequal-9-true 
        Label        -compare-lessequal-9-true 
        PushI        1                         
        Jump         -compare-lessequal-9-join 
        Label        -compare-lessequal-9-false 
        PushI        0                         
        Jump         -compare-lessequal-9-join 
        Label        -compare-lessequal-9-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-10-arg1 
        PushI        2                         
        Label        -compare-greaterequal-10-arg2 
        PushI        2                         
        Label        -compare-greaterequal-10-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-10-false 
        Jump         -compare-greaterequal-10-true 
        Label        -compare-greaterequal-10-true 
        PushI        1                         
        Jump         -compare-greaterequal-10-join 
        Label        -compare-greaterequal-10-false 
        PushI        0                         
        Jump         -compare-greaterequal-10-join 
        Label        -compare-greaterequal-10-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-11-arg1     
        PushI        2                         
        Label        -compare-less-11-arg2     
        PushI        2                         
        Label        -compare-less-11-sub      
        Subtract                               
        JumpNeg      -compare-less-11-true     
        Jump         -compare-less-11-false    
        Label        -compare-less-11-true     
        PushI        1                         
        Jump         -compare-less-11-join     
        Label        -compare-less-11-false    
        PushI        0                         
        Jump         -compare-less-11-join     
        Label        -compare-less-11-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-12-arg1  
        PushI        2                         
        Label        -compare-greater-12-arg2  
        PushI        2                         
        Label        -compare-greater-12-sub   
        Subtract                               
        JumpPos      -compare-greater-12-true  
        Jump         -compare-greater-12-false 
        Label        -compare-greater-12-true  
        PushI        1                         
        Jump         -compare-greater-12-join  
        Label        -compare-greater-12-false 
        PushI        0                         
        Jump         -compare-greater-12-join  
        Label        -compare-greater-12-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-13-arg1 
        PushI        2                         
        Label        -compare-notequal-13-arg2 
        PushI        2                         
        Label        -compare-notequal-13-sub  
        Subtract                               
        JumpTrue     -compare-notequal-13-true 
        Jump         -compare-notequal-13-false 
        Label        -compare-notequal-13-true 
        PushI        1                         
        Jump         -compare-notequal-13-join 
        Label        -compare-notequal-13-false 
        PushI        0                         
        Jump         -compare-notequal-13-join 
        Label        -compare-notequal-13-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-14-arg1    
        PushI        2                         
        Label        -compare-equal-14-arg2    
        PushI        3                         
        Label        -compare-equal-14-sub     
        Subtract                               
        JumpFalse    -compare-equal-14-true    
        Jump         -compare-equal-14-false   
        Label        -compare-equal-14-true    
        PushI        1                         
        Jump         -compare-equal-14-join    
        Label        -compare-equal-14-false   
        PushI        0                         
        Jump         -compare-equal-14-join    
        Label        -compare-equal-14-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-15-arg1 
        PushI        2                         
        Label        -compare-lessequal-15-arg2 
        PushI        3                         
        Label        -compare-lessequal-15-sub 
        Subtract                               
        JumpPos      -compare-lessequal-15-false 
        Jump         -compare-lessequal-15-true 
        Label        -compare-lessequal-15-true 
        PushI        1                         
        Jump         -compare-lessequal-15-join 
        Label        -compare-lessequal-15-false 
        PushI        0                         
        Jump         -compare-lessequal-15-join 
        Label        -compare-lessequal-15-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-16-arg1 
        PushI        2                         
        Label        -compare-greaterequal-16-arg2 
        PushI        3                         
        Label        -compare-greaterequal-16-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-16-false 
        Jump         -compare-greaterequal-16-true 
        Label        -compare-greaterequal-16-true 
        PushI        1                         
        Jump         -compare-greaterequal-16-join 
        Label        -compare-greaterequal-16-false 
        PushI        0                         
        Jump         -compare-greaterequal-16-join 
        Label        -compare-greaterequal-16-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-17-arg1     
        PushI        2                         
        Label        -compare-less-17-arg2     
        PushI        3                         
        Label        -compare-less-17-sub      
        Subtract                               
        JumpNeg      -compare-less-17-true     
        Jump         -compare-less-17-false    
        Label        -compare-less-17-true     
        PushI        1                         
        Jump         -compare-less-17-join     
        Label        -compare-less-17-false    
        PushI        0                         
        Jump         -compare-less-17-join     
        Label        -compare-less-17-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-18-arg1  
        PushI        2                         
        Label        -compare-greater-18-arg2  
        PushI        3                         
        Label        -compare-greater-18-sub   
        Subtract                               
        JumpPos      -compare-greater-18-true  
        Jump         -compare-greater-18-false 
        Label        -compare-greater-18-true  
        PushI        1                         
        Jump         -compare-greater-18-join  
        Label        -compare-greater-18-false 
        PushI        0                         
        Jump         -compare-greater-18-join  
        Label        -compare-greater-18-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-19-arg1 
        PushI        2                         
        Label        -compare-notequal-19-arg2 
        PushI        3                         
        Label        -compare-notequal-19-sub  
        Subtract                               
        JumpTrue     -compare-notequal-19-true 
        Jump         -compare-notequal-19-false 
        Label        -compare-notequal-19-true 
        PushI        1                         
        Jump         -compare-notequal-19-join 
        Label        -compare-notequal-19-false 
        PushI        0                         
        Jump         -compare-notequal-19-join 
        Label        -compare-notequal-19-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-20-arg1    
        PushI        3                         
        Label        -compare-equal-20-arg2    
        PushI        2                         
        Label        -compare-equal-20-sub     
        Subtract                               
        JumpFalse    -compare-equal-20-true    
        Jump         -compare-equal-20-false   
        Label        -compare-equal-20-true    
        PushI        1                         
        Jump         -compare-equal-20-join    
        Label        -compare-equal-20-false   
        PushI        0                         
        Jump         -compare-equal-20-join    
        Label        -compare-equal-20-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-21-arg1 
        PushI        3                         
        Label        -compare-lessequal-21-arg2 
        PushI        2                         
        Label        -compare-lessequal-21-sub 
        Subtract                               
        JumpPos      -compare-lessequal-21-false 
        Jump         -compare-lessequal-21-true 
        Label        -compare-lessequal-21-true 
        PushI        1                         
        Jump         -compare-lessequal-21-join 
        Label        -compare-lessequal-21-false 
        PushI        0                         
        Jump         -compare-lessequal-21-join 
        Label        -compare-lessequal-21-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-22-arg1 
        PushI        3                         
        Label        -compare-greaterequal-22-arg2 
        PushI        2                         
        Label        -compare-greaterequal-22-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-22-false 
        Jump         -compare-greaterequal-22-true 
        Label        -compare-greaterequal-22-true 
        PushI        1                         
        Jump         -compare-greaterequal-22-join 
        Label        -compare-greaterequal-22-false 
        PushI        0                         
        Jump         -compare-greaterequal-22-join 
        Label        -compare-greaterequal-22-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-23-arg1     
        PushI        3                         
        Label        -compare-less-23-arg2     
        PushI        2                         
        Label        -compare-less-23-sub      
        Subtract                               
        JumpNeg      -compare-less-23-true     
        Jump         -compare-less-23-false    
        Label        -compare-less-23-true     
        PushI        1                         
        Jump         -compare-less-23-join     
        Label        -compare-less-23-false    
        PushI        0                         
        Jump         -compare-less-23-join     
        Label        -compare-less-23-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-24-arg1  
        PushI        3                         
        Label        -compare-greater-24-arg2  
        PushI        2                         
        Label        -compare-greater-24-sub   
        Subtract                               
        JumpPos      -compare-greater-24-true  
        Jump         -compare-greater-24-false 
        Label        -compare-greater-24-true  
        PushI        1                         
        Jump         -compare-greater-24-join  
        Label        -compare-greater-24-false 
        PushI        0                         
        Jump         -compare-greater-24-join  
        Label        -compare-greater-24-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-25-arg1 
        PushI        3                         
        Label        -compare-notequal-25-arg2 
        PushI        2                         
        Label        -compare-notequal-25-sub  
        Subtract                               
        JumpTrue     -compare-notequal-25-true 
        Jump         -compare-notequal-25-false 
        Label        -compare-notequal-25-true 
        PushI        1                         
        Jump         -compare-notequal-25-join 
        Label        -compare-notequal-25-false 
        PushI        0                         
        Jump         -compare-notequal-25-join 
        Label        -compare-notequal-25-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-26-arg1    
        PushF        2.000000                  
        Label        -compare-equal-26-arg2    
        PushF        2.000000                  
        Label        -compare-equal-26-sub     
        FSubtract                              
        JumpFZero    -compare-equal-26-true    
        Jump         -compare-equal-26-false   
        Label        -compare-equal-26-true    
        PushI        1                         
        Jump         -compare-equal-26-join    
        Label        -compare-equal-26-false   
        PushI        0                         
        Jump         -compare-equal-26-join    
        Label        -compare-equal-26-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-27-arg1 
        PushF        2.000000                  
        Label        -compare-lessequal-27-arg2 
        PushF        2.000000                  
        Label        -compare-lessequal-27-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-27-false 
        Jump         -compare-lessequal-27-true 
        Label        -compare-lessequal-27-true 
        PushI        1                         
        Jump         -compare-lessequal-27-join 
        Label        -compare-lessequal-27-false 
        PushI        0                         
        Jump         -compare-lessequal-27-join 
        Label        -compare-lessequal-27-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-28-arg1 
        PushF        2.000000                  
        Label        -compare-greaterequal-28-arg2 
        PushF        2.000000                  
        Label        -compare-greaterequal-28-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-28-false 
        Jump         -compare-greaterequal-28-true 
        Label        -compare-greaterequal-28-true 
        PushI        1                         
        Jump         -compare-greaterequal-28-join 
        Label        -compare-greaterequal-28-false 
        PushI        0                         
        Jump         -compare-greaterequal-28-join 
        Label        -compare-greaterequal-28-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-29-arg1     
        PushF        2.000000                  
        Label        -compare-less-29-arg2     
        PushF        2.000000                  
        Label        -compare-less-29-sub      
        FSubtract                              
        JumpFNeg     -compare-less-29-true     
        Jump         -compare-less-29-false    
        Label        -compare-less-29-true     
        PushI        1                         
        Jump         -compare-less-29-join     
        Label        -compare-less-29-false    
        PushI        0                         
        Jump         -compare-less-29-join     
        Label        -compare-less-29-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-30-arg1  
        PushF        2.000000                  
        Label        -compare-greater-30-arg2  
        PushF        2.000000                  
        Label        -compare-greater-30-sub   
        FSubtract                              
        JumpFPos     -compare-greater-30-true  
        Jump         -compare-greater-30-false 
        Label        -compare-greater-30-true  
        PushI        1                         
        Jump         -compare-greater-30-join  
        Label        -compare-greater-30-false 
        PushI        0                         
        Jump         -compare-greater-30-join  
        Label        -compare-greater-30-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-31-arg1 
        PushF        2.000000                  
        Label        -compare-notequal-31-arg2 
        PushF        2.000000                  
        Label        -compare-notequal-31-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-31-false 
        Jump         -compare-notequal-31-true 
        Label        -compare-notequal-31-false 
        PushI        0                         
        Jump         -compare-notequal-31-join 
        Label        -compare-notequal-31-true 
        PushI        1                         
        Jump         -compare-notequal-31-join 
        Label        -compare-notequal-31-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-32-arg1    
        PushF        2.000000                  
        Label        -compare-equal-32-arg2    
        PushF        3.000000                  
        Label        -compare-equal-32-sub     
        FSubtract                              
        JumpFZero    -compare-equal-32-true    
        Jump         -compare-equal-32-false   
        Label        -compare-equal-32-true    
        PushI        1                         
        Jump         -compare-equal-32-join    
        Label        -compare-equal-32-false   
        PushI        0                         
        Jump         -compare-equal-32-join    
        Label        -compare-equal-32-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-33-arg1 
        PushF        2.000000                  
        Label        -compare-lessequal-33-arg2 
        PushF        3.000000                  
        Label        -compare-lessequal-33-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-33-false 
        Jump         -compare-lessequal-33-true 
        Label        -compare-lessequal-33-true 
        PushI        1                         
        Jump         -compare-lessequal-33-join 
        Label        -compare-lessequal-33-false 
        PushI        0                         
        Jump         -compare-lessequal-33-join 
        Label        -compare-lessequal-33-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-34-arg1 
        PushF        2.000000                  
        Label        -compare-greaterequal-34-arg2 
        PushF        3.000000                  
        Label        -compare-greaterequal-34-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-34-false 
        Jump         -compare-greaterequal-34-true 
        Label        -compare-greaterequal-34-true 
        PushI        1                         
        Jump         -compare-greaterequal-34-join 
        Label        -compare-greaterequal-34-false 
        PushI        0                         
        Jump         -compare-greaterequal-34-join 
        Label        -compare-greaterequal-34-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-35-arg1     
        PushF        2.000000                  
        Label        -compare-less-35-arg2     
        PushF        3.000000                  
        Label        -compare-less-35-sub      
        FSubtract                              
        JumpFNeg     -compare-less-35-true     
        Jump         -compare-less-35-false    
        Label        -compare-less-35-true     
        PushI        1                         
        Jump         -compare-less-35-join     
        Label        -compare-less-35-false    
        PushI        0                         
        Jump         -compare-less-35-join     
        Label        -compare-less-35-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-36-arg1  
        PushF        2.000000                  
        Label        -compare-greater-36-arg2  
        PushF        3.000000                  
        Label        -compare-greater-36-sub   
        FSubtract                              
        JumpFPos     -compare-greater-36-true  
        Jump         -compare-greater-36-false 
        Label        -compare-greater-36-true  
        PushI        1                         
        Jump         -compare-greater-36-join  
        Label        -compare-greater-36-false 
        PushI        0                         
        Jump         -compare-greater-36-join  
        Label        -compare-greater-36-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-37-arg1 
        PushF        2.000000                  
        Label        -compare-notequal-37-arg2 
        PushF        3.000000                  
        Label        -compare-notequal-37-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-37-false 
        Jump         -compare-notequal-37-true 
        Label        -compare-notequal-37-false 
        PushI        0                         
        Jump         -compare-notequal-37-join 
        Label        -compare-notequal-37-true 
        PushI        1                         
        Jump         -compare-notequal-37-join 
        Label        -compare-notequal-37-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-38-arg1    
        PushF        3.000000                  
        Label        -compare-equal-38-arg2    
        PushF        2.000000                  
        Label        -compare-equal-38-sub     
        FSubtract                              
        JumpFZero    -compare-equal-38-true    
        Jump         -compare-equal-38-false   
        Label        -compare-equal-38-true    
        PushI        1                         
        Jump         -compare-equal-38-join    
        Label        -compare-equal-38-false   
        PushI        0                         
        Jump         -compare-equal-38-join    
        Label        -compare-equal-38-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-39-arg1 
        PushF        3.000000                  
        Label        -compare-lessequal-39-arg2 
        PushF        2.000000                  
        Label        -compare-lessequal-39-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-39-false 
        Jump         -compare-lessequal-39-true 
        Label        -compare-lessequal-39-true 
        PushI        1                         
        Jump         -compare-lessequal-39-join 
        Label        -compare-lessequal-39-false 
        PushI        0                         
        Jump         -compare-lessequal-39-join 
        Label        -compare-lessequal-39-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-40-arg1 
        PushF        3.000000                  
        Label        -compare-greaterequal-40-arg2 
        PushF        2.000000                  
        Label        -compare-greaterequal-40-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-40-false 
        Jump         -compare-greaterequal-40-true 
        Label        -compare-greaterequal-40-true 
        PushI        1                         
        Jump         -compare-greaterequal-40-join 
        Label        -compare-greaterequal-40-false 
        PushI        0                         
        Jump         -compare-greaterequal-40-join 
        Label        -compare-greaterequal-40-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-41-arg1     
        PushF        3.000000                  
        Label        -compare-less-41-arg2     
        PushF        2.000000                  
        Label        -compare-less-41-sub      
        FSubtract                              
        JumpFNeg     -compare-less-41-true     
        Jump         -compare-less-41-false    
        Label        -compare-less-41-true     
        PushI        1                         
        Jump         -compare-less-41-join     
        Label        -compare-less-41-false    
        PushI        0                         
        Jump         -compare-less-41-join     
        Label        -compare-less-41-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-42-arg1  
        PushF        3.000000                  
        Label        -compare-greater-42-arg2  
        PushF        2.000000                  
        Label        -compare-greater-42-sub   
        FSubtract                              
        JumpFPos     -compare-greater-42-true  
        Jump         -compare-greater-42-false 
        Label        -compare-greater-42-true  
        PushI        1                         
        Jump         -compare-greater-42-join  
        Label        -compare-greater-42-false 
        PushI        0                         
        Jump         -compare-greater-42-join  
        Label        -compare-greater-42-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-43-arg1 
        PushF        3.000000                  
        Label        -compare-notequal-43-arg2 
        PushF        2.000000                  
        Label        -compare-notequal-43-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-43-false 
        Jump         -compare-notequal-43-true 
        Label        -compare-notequal-43-false 
        PushI        0                         
        Jump         -compare-notequal-43-join 
        Label        -compare-notequal-43-true 
        PushI        1                         
        Jump         -compare-notequal-43-join 
        Label        -compare-notequal-43-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        PushI        3                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Call         $print-string             
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        PushI        3                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        LoadI                                  
        Call         $print-string             
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        PushI        4                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        LoadI                                  
        Call         $print-string             
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% c
        PushI        4                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        LoadI                                  
        Call         $print-string             
        PushD        $print-format-space       
        Printf                                 
        PushI        10                        
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        10                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        22                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        19                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        20                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        21                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Call         $print-string             
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-44-arg1 
        PushF        0.000010                  
        Label        -compare-lessequal-44-arg2 
        PushF        0.000001                  
        Label        -compare-lessequal-44-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-44-false 
        Jump         -compare-lessequal-44-true 
        Label        -compare-lessequal-44-true 
        PushI        1                         
        Jump         -compare-lessequal-44-join 
        Label        -compare-lessequal-44-false 
        PushI        0                         
        Jump         -compare-lessequal-44-join 
        Label        -compare-lessequal-44-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-45-arg1 
        PushF        0.000010                  
        Label        -compare-greaterequal-45-arg2 
        PushF        0.000001                  
        Label        -compare-greaterequal-45-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-45-false 
        Jump         -compare-greaterequal-45-true 
        Label        -compare-greaterequal-45-true 
        PushI        1                         
        Jump         -compare-greaterequal-45-join 
        Label        -compare-greaterequal-45-false 
        PushI        0                         
        Jump         -compare-greaterequal-45-join 
        Label        -compare-greaterequal-45-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-equal-46-arg1    
        PushF        0.000010                  
        Label        -compare-equal-46-arg2    
        PushF        0.000001                  
        Label        -compare-equal-46-sub     
        FSubtract                              
        JumpFZero    -compare-equal-46-true    
        Jump         -compare-equal-46-false   
        Label        -compare-equal-46-true    
        PushI        1                         
        Jump         -compare-equal-46-join    
        Label        -compare-equal-46-false   
        PushI        0                         
        Jump         -compare-equal-46-join    
        Label        -compare-equal-46-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-47-arg1 
        PushF        0.000010                  
        Label        -compare-notequal-47-arg2 
        PushF        0.000001                  
        Label        -compare-notequal-47-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-47-false 
        Jump         -compare-notequal-47-true 
        Label        -compare-notequal-47-false 
        PushI        0                         
        Jump         -compare-notequal-47-join 
        Label        -compare-notequal-47-true 
        PushI        1                         
        Jump         -compare-notequal-47-join 
        Label        -compare-notequal-47-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-48-arg1 
        PushF        0.000001                  
        Label        -compare-lessequal-48-arg2 
        PushF        0.000000                  
        Label        -compare-lessequal-48-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-48-false 
        Jump         -compare-lessequal-48-true 
        Label        -compare-lessequal-48-true 
        PushI        1                         
        Jump         -compare-lessequal-48-join 
        Label        -compare-lessequal-48-false 
        PushI        0                         
        Jump         -compare-lessequal-48-join 
        Label        -compare-lessequal-48-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-49-arg1 
        PushF        0.000001                  
        Label        -compare-greaterequal-49-arg2 
        PushF        0.000000                  
        Label        -compare-greaterequal-49-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-49-false 
        Jump         -compare-greaterequal-49-true 
        Label        -compare-greaterequal-49-true 
        PushI        1                         
        Jump         -compare-greaterequal-49-join 
        Label        -compare-greaterequal-49-false 
        PushI        0                         
        Jump         -compare-greaterequal-49-join 
        Label        -compare-greaterequal-49-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-equal-50-arg1    
        PushF        0.000001                  
        Label        -compare-equal-50-arg2    
        PushF        0.000000                  
        Label        -compare-equal-50-sub     
        FSubtract                              
        JumpFZero    -compare-equal-50-true    
        Jump         -compare-equal-50-false   
        Label        -compare-equal-50-true    
        PushI        1                         
        Jump         -compare-equal-50-join    
        Label        -compare-equal-50-false   
        PushI        0                         
        Jump         -compare-equal-50-join    
        Label        -compare-equal-50-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-51-arg1 
        PushF        0.000001                  
        Label        -compare-notequal-51-arg2 
        PushF        0.000000                  
        Label        -compare-notequal-51-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-51-false 
        Jump         -compare-notequal-51-true 
        Label        -compare-notequal-51-false 
        PushI        0                         
        Jump         -compare-notequal-51-join 
        Label        -compare-notequal-51-true 
        PushI        1                         
        Jump         -compare-notequal-51-join 
        Label        -compare-notequal-51-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushF        0.000000                  
        PushF        0.000000                  
        FSubtract                              
        PushD        $print-format-floating    
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-52-arg1 
        PushF        0.000000                  
        Label        -compare-lessequal-52-arg2 
        PushF        0.000000                  
        Label        -compare-lessequal-52-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-52-false 
        Jump         -compare-lessequal-52-true 
        Label        -compare-lessequal-52-true 
        PushI        1                         
        Jump         -compare-lessequal-52-join 
        Label        -compare-lessequal-52-false 
        PushI        0                         
        Jump         -compare-lessequal-52-join 
        Label        -compare-lessequal-52-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-53-arg1 
        PushF        0.000000                  
        Label        -compare-greaterequal-53-arg2 
        PushF        0.000000                  
        Label        -compare-greaterequal-53-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-53-false 
        Jump         -compare-greaterequal-53-true 
        Label        -compare-greaterequal-53-true 
        PushI        1                         
        Jump         -compare-greaterequal-53-join 
        Label        -compare-greaterequal-53-false 
        PushI        0                         
        Jump         -compare-greaterequal-53-join 
        Label        -compare-greaterequal-53-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-equal-54-arg1    
        PushF        0.000000                  
        Label        -compare-equal-54-arg2    
        PushF        0.000000                  
        Label        -compare-equal-54-sub     
        FSubtract                              
        JumpFZero    -compare-equal-54-true    
        Jump         -compare-equal-54-false   
        Label        -compare-equal-54-true    
        PushI        1                         
        Jump         -compare-equal-54-join    
        Label        -compare-equal-54-false   
        PushI        0                         
        Jump         -compare-equal-54-join    
        Label        -compare-equal-54-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-55-arg1 
        PushF        0.000000                  
        Label        -compare-notequal-55-arg2 
        PushF        0.000000                  
        Label        -compare-notequal-55-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-55-false 
        Jump         -compare-notequal-55-true 
        Label        -compare-notequal-55-false 
        PushI        0                         
        Jump         -compare-notequal-55-join 
        Label        -compare-notequal-55-true 
        PushI        1                         
        Jump         -compare-notequal-55-join 
        Label        -compare-notequal-55-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-56-arg1    
        PushI        1                         
        Label        -compare-equal-56-arg2    
        PushI        1                         
        Label        -compare-equal-56-sub     
        Subtract                               
        JumpFalse    -compare-equal-56-true    
        Jump         -compare-equal-56-false   
        Label        -compare-equal-56-true    
        PushI        1                         
        Jump         -compare-equal-56-join    
        Label        -compare-equal-56-false   
        PushI        0                         
        Jump         -compare-equal-56-join    
        Label        -compare-equal-56-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-57-arg1 
        PushI        1                         
        Label        -compare-notequal-57-arg2 
        PushI        1                         
        Label        -compare-notequal-57-sub  
        Subtract                               
        JumpTrue     -compare-notequal-57-true 
        Jump         -compare-notequal-57-false 
        Label        -compare-notequal-57-true 
        PushI        1                         
        Jump         -compare-notequal-57-join 
        Label        -compare-notequal-57-false 
        PushI        0                         
        Jump         -compare-notequal-57-join 
        Label        -compare-notequal-57-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-58-arg1    
        PushI        0                         
        Label        -compare-equal-58-arg2    
        PushI        0                         
        Label        -compare-equal-58-sub     
        Subtract                               
        JumpFalse    -compare-equal-58-true    
        Jump         -compare-equal-58-false   
        Label        -compare-equal-58-true    
        PushI        1                         
        Jump         -compare-equal-58-join    
        Label        -compare-equal-58-false   
        PushI        0                         
        Jump         -compare-equal-58-join    
        Label        -compare-equal-58-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-59-arg1 
        PushI        0                         
        Label        -compare-notequal-59-arg2 
        PushI        0                         
        Label        -compare-notequal-59-sub  
        Subtract                               
        JumpTrue     -compare-notequal-59-true 
        Jump         -compare-notequal-59-false 
        Label        -compare-notequal-59-true 
        PushI        1                         
        Jump         -compare-notequal-59-join 
        Label        -compare-notequal-59-false 
        PushI        0                         
        Jump         -compare-notequal-59-join 
        Label        -compare-notequal-59-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-60-arg1    
        PushI        1                         
        Label        -compare-equal-60-arg2    
        PushI        0                         
        Label        -compare-equal-60-sub     
        Subtract                               
        JumpFalse    -compare-equal-60-true    
        Jump         -compare-equal-60-false   
        Label        -compare-equal-60-true    
        PushI        1                         
        Jump         -compare-equal-60-join    
        Label        -compare-equal-60-false   
        PushI        0                         
        Jump         -compare-equal-60-join    
        Label        -compare-equal-60-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-61-arg1 
        PushI        1                         
        Label        -compare-notequal-61-arg2 
        PushI        0                         
        Label        -compare-notequal-61-sub  
        Subtract                               
        JumpTrue     -compare-notequal-61-true 
        Jump         -compare-notequal-61-false 
        Label        -compare-notequal-61-true 
        PushI        1                         
        Jump         -compare-notequal-61-join 
        Label        -compare-notequal-61-false 
        PushI        0                         
        Jump         -compare-notequal-61-join 
        Label        -compare-notequal-61-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-62-arg1    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-62-arg2    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-62-sub     
        Subtract                               
        JumpFalse    -compare-equal-62-true    
        Jump         -compare-equal-62-false   
        Label        -compare-equal-62-true    
        PushI        1                         
        Jump         -compare-equal-62-join    
        Label        -compare-equal-62-false   
        PushI        0                         
        Jump         -compare-equal-62-join    
        Label        -compare-equal-62-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-63-arg1 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-63-arg2 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-63-sub  
        Subtract                               
        JumpTrue     -compare-notequal-63-true 
        Jump         -compare-notequal-63-false 
        Label        -compare-notequal-63-true 
        PushI        1                         
        Jump         -compare-notequal-63-join 
        Label        -compare-notequal-63-false 
        PushI        0                         
        Jump         -compare-notequal-63-join 
        Label        -compare-notequal-63-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-64-arg1    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-64-arg2    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        98                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-64-sub     
        Subtract                               
        JumpFalse    -compare-equal-64-true    
        Jump         -compare-equal-64-false   
        Label        -compare-equal-64-true    
        PushI        1                         
        Jump         -compare-equal-64-join    
        Label        -compare-equal-64-false   
        PushI        0                         
        Jump         -compare-equal-64-join    
        Label        -compare-equal-64-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-65-arg1 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-65-arg2 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        98                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-65-sub  
        Subtract                               
        JumpTrue     -compare-notequal-65-true 
        Jump         -compare-notequal-65-false 
        Label        -compare-notequal-65-true 
        PushI        1                         
        Jump         -compare-notequal-65-join 
        Label        -compare-notequal-65-false 
        PushI        0                         
        Jump         -compare-notequal-65-join 
        Label        -compare-notequal-65-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-66-arg1    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        98                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-66-arg2    
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-equal-66-sub     
        Subtract                               
        JumpFalse    -compare-equal-66-true    
        Jump         -compare-equal-66-false   
        Label        -compare-equal-66-true    
        PushI        1                         
        Jump         -compare-equal-66-join    
        Label        -compare-equal-66-false   
        PushI        0                         
        Jump         -compare-equal-66-join    
        Label        -compare-equal-66-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-67-arg1 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        98                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-67-arg2 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        97                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Label        -compare-notequal-67-sub  
        Subtract                               
        JumpTrue     -compare-notequal-67-true 
        Jump         -compare-notequal-67-false 
        Label        -compare-notequal-67-true 
        PushI        1                         
        Jump         -compare-notequal-67-join 
        Label        -compare-notequal-67-false 
        PushI        0                         
        Jump         -compare-notequal-67-join 
        Label        -compare-notequal-67-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-68-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-equal-68-arg2    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-equal-68-sub     
        Subtract                               
        JumpFalse    -compare-equal-68-true    
        Jump         -compare-equal-68-false   
        Label        -compare-equal-68-true    
        PushI        1                         
        Jump         -compare-equal-68-join    
        Label        -compare-equal-68-false   
        PushI        0                         
        Jump         -compare-equal-68-join    
        Label        -compare-equal-68-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-69-arg1 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-notequal-69-arg2 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-notequal-69-sub  
        Subtract                               
        JumpTrue     -compare-notequal-69-true 
        Jump         -compare-notequal-69-false 
        Label        -compare-notequal-69-true 
        PushI        1                         
        Jump         -compare-notequal-69-join 
        Label        -compare-notequal-69-false 
        PushI        0                         
        Jump         -compare-notequal-69-join 
        Label        -compare-notequal-69-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-70-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-equal-70-arg2    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% c
        LoadI                                  
        Label        -compare-equal-70-sub     
        Subtract                               
        JumpFalse    -compare-equal-70-true    
        Jump         -compare-equal-70-false   
        Label        -compare-equal-70-true    
        PushI        1                         
        Jump         -compare-equal-70-join    
        Label        -compare-equal-70-false   
        PushI        0                         
        Jump         -compare-equal-70-join    
        Label        -compare-equal-70-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-71-arg1 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-notequal-71-arg2 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% c
        LoadI                                  
        Label        -compare-notequal-71-sub  
        Subtract                               
        JumpTrue     -compare-notequal-71-true 
        Jump         -compare-notequal-71-false 
        Label        -compare-notequal-71-true 
        PushI        1                         
        Jump         -compare-notequal-71-join 
        Label        -compare-notequal-71-false 
        PushI        0                         
        Jump         -compare-notequal-71-join 
        Label        -compare-notequal-71-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-72-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-equal-72-arg2    
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        LoadI                                  
        Label        -compare-equal-72-sub     
        Subtract                               
        JumpFalse    -compare-equal-72-true    
        Jump         -compare-equal-72-false   
        Label        -compare-equal-72-true    
        PushI        1                         
        Jump         -compare-equal-72-join    
        Label        -compare-equal-72-false   
        PushI        0                         
        Jump         -compare-equal-72-join    
        Label        -compare-equal-72-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-73-arg1 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        LoadI                                  
        Label        -compare-notequal-73-arg2 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% b
        LoadI                                  
        Label        -compare-notequal-73-sub  
        Subtract                               
        JumpTrue     -compare-notequal-73-true 
        Jump         -compare-notequal-73-false 
        Label        -compare-notequal-73-true 
        PushI        1                         
        Jump         -compare-notequal-73-join 
        Label        -compare-notequal-73-false 
        PushI        0                         
        Jump         -compare-notequal-73-join 
        Label        -compare-notequal-73-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-74-arg1    
        PushI        97                        
        Label        -compare-equal-74-arg2    
        PushI        97                        
        Label        -compare-equal-74-sub     
        Subtract                               
        JumpFalse    -compare-equal-74-true    
        Jump         -compare-equal-74-false   
        Label        -compare-equal-74-true    
        PushI        1                         
        Jump         -compare-equal-74-join    
        Label        -compare-equal-74-false   
        PushI        0                         
        Jump         -compare-equal-74-join    
        Label        -compare-equal-74-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-75-arg1 
        PushI        97                        
        Label        -compare-lessequal-75-arg2 
        PushI        97                        
        Label        -compare-lessequal-75-sub 
        Subtract                               
        JumpPos      -compare-lessequal-75-false 
        Jump         -compare-lessequal-75-true 
        Label        -compare-lessequal-75-true 
        PushI        1                         
        Jump         -compare-lessequal-75-join 
        Label        -compare-lessequal-75-false 
        PushI        0                         
        Jump         -compare-lessequal-75-join 
        Label        -compare-lessequal-75-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-76-arg1 
        PushI        97                        
        Label        -compare-greaterequal-76-arg2 
        PushI        97                        
        Label        -compare-greaterequal-76-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-76-false 
        Jump         -compare-greaterequal-76-true 
        Label        -compare-greaterequal-76-true 
        PushI        1                         
        Jump         -compare-greaterequal-76-join 
        Label        -compare-greaterequal-76-false 
        PushI        0                         
        Jump         -compare-greaterequal-76-join 
        Label        -compare-greaterequal-76-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-77-arg1     
        PushI        97                        
        Label        -compare-less-77-arg2     
        PushI        97                        
        Label        -compare-less-77-sub      
        Subtract                               
        JumpNeg      -compare-less-77-true     
        Jump         -compare-less-77-false    
        Label        -compare-less-77-true     
        PushI        1                         
        Jump         -compare-less-77-join     
        Label        -compare-less-77-false    
        PushI        0                         
        Jump         -compare-less-77-join     
        Label        -compare-less-77-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-78-arg1  
        PushI        97                        
        Label        -compare-greater-78-arg2  
        PushI        97                        
        Label        -compare-greater-78-sub   
        Subtract                               
        JumpPos      -compare-greater-78-true  
        Jump         -compare-greater-78-false 
        Label        -compare-greater-78-true  
        PushI        1                         
        Jump         -compare-greater-78-join  
        Label        -compare-greater-78-false 
        PushI        0                         
        Jump         -compare-greater-78-join  
        Label        -compare-greater-78-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-79-arg1 
        PushI        97                        
        Label        -compare-notequal-79-arg2 
        PushI        97                        
        Label        -compare-notequal-79-sub  
        Subtract                               
        JumpTrue     -compare-notequal-79-true 
        Jump         -compare-notequal-79-false 
        Label        -compare-notequal-79-true 
        PushI        1                         
        Jump         -compare-notequal-79-join 
        Label        -compare-notequal-79-false 
        PushI        0                         
        Jump         -compare-notequal-79-join 
        Label        -compare-notequal-79-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-80-arg1    
        PushI        97                        
        Label        -compare-equal-80-arg2    
        PushI        98                        
        Label        -compare-equal-80-sub     
        Subtract                               
        JumpFalse    -compare-equal-80-true    
        Jump         -compare-equal-80-false   
        Label        -compare-equal-80-true    
        PushI        1                         
        Jump         -compare-equal-80-join    
        Label        -compare-equal-80-false   
        PushI        0                         
        Jump         -compare-equal-80-join    
        Label        -compare-equal-80-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-81-arg1 
        PushI        97                        
        Label        -compare-lessequal-81-arg2 
        PushI        98                        
        Label        -compare-lessequal-81-sub 
        Subtract                               
        JumpPos      -compare-lessequal-81-false 
        Jump         -compare-lessequal-81-true 
        Label        -compare-lessequal-81-true 
        PushI        1                         
        Jump         -compare-lessequal-81-join 
        Label        -compare-lessequal-81-false 
        PushI        0                         
        Jump         -compare-lessequal-81-join 
        Label        -compare-lessequal-81-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-82-arg1 
        PushI        97                        
        Label        -compare-greaterequal-82-arg2 
        PushI        98                        
        Label        -compare-greaterequal-82-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-82-false 
        Jump         -compare-greaterequal-82-true 
        Label        -compare-greaterequal-82-true 
        PushI        1                         
        Jump         -compare-greaterequal-82-join 
        Label        -compare-greaterequal-82-false 
        PushI        0                         
        Jump         -compare-greaterequal-82-join 
        Label        -compare-greaterequal-82-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-83-arg1     
        PushI        97                        
        Label        -compare-less-83-arg2     
        PushI        98                        
        Label        -compare-less-83-sub      
        Subtract                               
        JumpNeg      -compare-less-83-true     
        Jump         -compare-less-83-false    
        Label        -compare-less-83-true     
        PushI        1                         
        Jump         -compare-less-83-join     
        Label        -compare-less-83-false    
        PushI        0                         
        Jump         -compare-less-83-join     
        Label        -compare-less-83-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-84-arg1  
        PushI        97                        
        Label        -compare-greater-84-arg2  
        PushI        98                        
        Label        -compare-greater-84-sub   
        Subtract                               
        JumpPos      -compare-greater-84-true  
        Jump         -compare-greater-84-false 
        Label        -compare-greater-84-true  
        PushI        1                         
        Jump         -compare-greater-84-join  
        Label        -compare-greater-84-false 
        PushI        0                         
        Jump         -compare-greater-84-join  
        Label        -compare-greater-84-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-85-arg1 
        PushI        97                        
        Label        -compare-notequal-85-arg2 
        PushI        98                        
        Label        -compare-notequal-85-sub  
        Subtract                               
        JumpTrue     -compare-notequal-85-true 
        Jump         -compare-notequal-85-false 
        Label        -compare-notequal-85-true 
        PushI        1                         
        Jump         -compare-notequal-85-join 
        Label        -compare-notequal-85-false 
        PushI        0                         
        Jump         -compare-notequal-85-join 
        Label        -compare-notequal-85-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-86-arg1    
        PushI        98                        
        Label        -compare-equal-86-arg2    
        PushI        97                        
        Label        -compare-equal-86-sub     
        Subtract                               
        JumpFalse    -compare-equal-86-true    
        Jump         -compare-equal-86-false   
        Label        -compare-equal-86-true    
        PushI        1                         
        Jump         -compare-equal-86-join    
        Label        -compare-equal-86-false   
        PushI        0                         
        Jump         -compare-equal-86-join    
        Label        -compare-equal-86-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-87-arg1 
        PushI        98                        
        Label        -compare-lessequal-87-arg2 
        PushI        97                        
        Label        -compare-lessequal-87-sub 
        Subtract                               
        JumpPos      -compare-lessequal-87-false 
        Jump         -compare-lessequal-87-true 
        Label        -compare-lessequal-87-true 
        PushI        1                         
        Jump         -compare-lessequal-87-join 
        Label        -compare-lessequal-87-false 
        PushI        0                         
        Jump         -compare-lessequal-87-join 
        Label        -compare-lessequal-87-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-88-arg1 
        PushI        98                        
        Label        -compare-greaterequal-88-arg2 
        PushI        97                        
        Label        -compare-greaterequal-88-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-88-false 
        Jump         -compare-greaterequal-88-true 
        Label        -compare-greaterequal-88-true 
        PushI        1                         
        Jump         -compare-greaterequal-88-join 
        Label        -compare-greaterequal-88-false 
        PushI        0                         
        Jump         -compare-greaterequal-88-join 
        Label        -compare-greaterequal-88-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-89-arg1     
        PushI        98                        
        Label        -compare-less-89-arg2     
        PushI        97                        
        Label        -compare-less-89-sub      
        Subtract                               
        JumpNeg      -compare-less-89-true     
        Jump         -compare-less-89-false    
        Label        -compare-less-89-true     
        PushI        1                         
        Jump         -compare-less-89-join     
        Label        -compare-less-89-false    
        PushI        0                         
        Jump         -compare-less-89-join     
        Label        -compare-less-89-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-90-arg1  
        PushI        98                        
        Label        -compare-greater-90-arg2  
        PushI        97                        
        Label        -compare-greater-90-sub   
        Subtract                               
        JumpPos      -compare-greater-90-true  
        Jump         -compare-greater-90-false 
        Label        -compare-greater-90-true  
        PushI        1                         
        Jump         -compare-greater-90-join  
        Label        -compare-greater-90-false 
        PushI        0                         
        Jump         -compare-greater-90-join  
        Label        -compare-greater-90-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-91-arg1 
        PushI        98                        
        Label        -compare-notequal-91-arg2 
        PushI        97                        
        Label        -compare-notequal-91-sub  
        Subtract                               
        JumpTrue     -compare-notequal-91-true 
        Jump         -compare-notequal-91-false 
        Label        -compare-notequal-91-true 
        PushI        1                         
        Jump         -compare-notequal-91-join 
        Label        -compare-notequal-91-false 
        PushI        0                         
        Jump         -compare-notequal-91-join 
        Label        -compare-notequal-91-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-93-arg1    
        Label        -compare-less-92-arg1     
        PushI        1                         
        Label        -compare-less-92-arg2     
        PushI        2                         
        Label        -compare-less-92-sub      
        Subtract                               
        JumpNeg      -compare-less-92-true     
        Jump         -compare-less-92-false    
        Label        -compare-less-92-true     
        PushI        1                         
        Jump         -compare-less-92-join     
        Label        -compare-less-92-false    
        PushI        0                         
        Jump         -compare-less-92-join     
        Label        -compare-less-92-join     
        Label        -compare-equal-93-arg2    
        PushI        1                         
        Label        -compare-equal-93-sub     
        Subtract                               
        JumpFalse    -compare-equal-93-true    
        Jump         -compare-equal-93-false   
        Label        -compare-equal-93-true    
        PushI        1                         
        Jump         -compare-equal-93-join    
        Label        -compare-equal-93-false   
        PushI        0                         
        Jump         -compare-equal-93-join    
        Label        -compare-equal-93-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        Halt                                   
        Label        -mem-manager-make-tags    
        DLabel       $mmgr-tags-size           
        DataZ        4                         
        DLabel       $mmgr-tags-start          
        DataZ        4                         
        DLabel       $mmgr-tags-available      
        DataZ        4                         
        DLabel       $mmgr-tags-nextptr        
        DataZ        4                         
        DLabel       $mmgr-tags-prevptr        
        DataZ        4                         
        DLabel       $mmgr-tags-return         
        DataZ        4                         
        PushD        $mmgr-tags-return         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-size           
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-start          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-available      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-nextptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-nextptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-return         
        LoadI                                  
        Return                                 
        Label        -mem-manager-one-tag      
        DLabel       $mmgr-onetag-return       
        DataZ        4                         
        DLabel       $mmgr-onetag-location     
        DataZ        4                         
        DLabel       $mmgr-onetag-available    
        DataZ        4                         
        DLabel       $mmgr-onetag-size         
        DataZ        4                         
        DLabel       $mmgr-onetag-pointer      
        DataZ        4                         
        PushD        $mmgr-onetag-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-onetag-return       
        LoadI                                  
        Return                                 
        Label        -mem-manager-allocate     
        DLabel       $mmgr-alloc-return        
        DataZ        4                         
        DLabel       $mmgr-alloc-size          
        DataZ        4                         
        DLabel       $mmgr-alloc-current-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-size 
        DataZ        4                         
        PushD        $mmgr-alloc-return        
        Exchange                               
        StoreI                                 
        PushI        18                        
        Add                                    
        PushD        $mmgr-alloc-size          
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-process-current 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        JumpFalse    -mmgr-alloc-no-block-works 
        Label        -mmgr-alloc-test-block    
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        1                         
        Add                                    
        JumpPos      -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Jump         -mmgr-alloc-process-current 
        Label        -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Call         -mem-manager-remove-block 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        26                        
        Subtract                               
        JumpNeg      -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Add                                    
        PushD        $mmgr-alloc-remainder-block 
        Exchange                               
        StoreI                                 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $mmgr-alloc-remainder-size 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushI        0                         
        PushI        0                         
        PushI        1                         
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushD        $mmgr-alloc-remainder-size 
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        Call         -mem-manager-deallocate   
        Jump         -mmgr-alloc-return-userblock 
        Label        -mmgr-alloc-no-block-works 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-newblock-size       
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        LoadI                                  
        PushD        $mmgr-newblock-block      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-newblock-size       
        LoadI                                  
        PushD        $heap-after-ptr           
        LoadI                                  
        Add                                    
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-newblock-size       
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        PushD        $mmgr-alloc-return        
        LoadI                                  
        Return                                 
        Label        -mem-manager-deallocate   
        DLabel       $mmgr-dealloc-return      
        DataZ        4                         
        DLabel       $mmgr-dealloc-block       
        DataZ        4                         
        PushD        $mmgr-dealloc-return      
        Exchange                               
        StoreI                                 
        PushI        9                         
        Subtract                               
        PushD        $mmgr-dealloc-block       
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        JumpFalse    -mmgr-bypass-firstFree    
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-bypass-firstFree    
        PushI        0                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-dealloc-return      
        LoadI                                  
        Return                                 
        Label        -mem-manager-remove-block 
        DLabel       $mmgr-remove-return       
        DataZ        4                         
        DLabel       $mmgr-remove-block        
        DataZ        4                         
        DLabel       $mmgr-remove-prev         
        DataZ        4                         
        DLabel       $mmgr-remove-next         
        DataZ        4                         
        PushD        $mmgr-remove-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-prev         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-next         
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-prev 
        PushD        $mmgr-remove-prev         
        LoadI                                  
        JumpFalse    -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $mmgr-remove-prev         
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Jump         -mmgr-remove-process-next 
        Label        -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-next 
        PushD        $mmgr-remove-next         
        LoadI                                  
        JumpFalse    -mmgr-remove-done         
        PushD        $mmgr-remove-prev         
        LoadI                                  
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-done         
        PushD        $mmgr-remove-return       
        LoadI                                  
        Return                                 
        DLabel       $heap-memory              
