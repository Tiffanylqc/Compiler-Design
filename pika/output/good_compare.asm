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
        DataZ        0                         
        Label        $$main                    
        Label        -compare-less-8-arg1      
        PushI        1                         
        Label        -compare-less-8-arg2      
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-less-8-sub       
        Subtract                               
        JumpNeg      -compare-less-8-true      
        Jump         -compare-less-8-false     
        Label        -compare-less-8-true      
        PushI        1                         
        Jump         -compare-less-8-join      
        Label        -compare-less-8-false     
        PushI        0                         
        Jump         -compare-less-8-join      
        Label        -compare-less-8-join      
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-9-arg1      
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-less-9-arg2      
        PushI        1                         
        Label        -compare-less-9-sub       
        Subtract                               
        JumpNeg      -compare-less-9-true      
        Jump         -compare-less-9-false     
        Label        -compare-less-9-true      
        PushI        1                         
        Jump         -compare-less-9-join      
        Label        -compare-less-9-false     
        PushI        0                         
        Jump         -compare-less-9-join      
        Label        -compare-less-9-join      
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-less-10-arg1     
        PushI        97                        
        ConvertF                               
        Label        -compare-less-10-arg2     
        PushF        2.200000                  
        Label        -compare-less-10-sub      
        FSubtract                              
        JumpFNeg     -compare-less-10-true     
        Jump         -compare-less-10-false    
        Label        -compare-less-10-true     
        PushI        1                         
        Jump         -compare-less-10-join     
        Label        -compare-less-10-false    
        PushI        0                         
        Jump         -compare-less-10-join     
        Label        -compare-less-10-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-11-arg1     
        PushF        2.200000                  
        Label        -compare-less-11-arg2     
        PushI        97                        
        ConvertF                               
        Label        -compare-less-11-sub      
        FSubtract                              
        JumpFNeg     -compare-less-11-true     
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
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-less-12-arg1     
        PushI        2                         
        ConvertF                               
        Label        -compare-less-12-arg2     
        PushF        2.200000                  
        Label        -compare-less-12-sub      
        FSubtract                              
        JumpFNeg     -compare-less-12-true     
        Jump         -compare-less-12-false    
        Label        -compare-less-12-true     
        PushI        1                         
        Jump         -compare-less-12-join     
        Label        -compare-less-12-false    
        PushI        0                         
        Jump         -compare-less-12-join     
        Label        -compare-less-12-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-less-13-arg1     
        PushF        2.200000                  
        Label        -compare-less-13-arg2     
        PushI        2                         
        ConvertF                               
        Label        -compare-less-13-sub      
        FSubtract                              
        JumpFNeg     -compare-less-13-true     
        Jump         -compare-less-13-false    
        Label        -compare-less-13-true     
        PushI        1                         
        Jump         -compare-less-13-join     
        Label        -compare-less-13-false    
        PushI        0                         
        Jump         -compare-less-13-join     
        Label        -compare-less-13-join     
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-14-arg1 
        PushI        1                         
        Label        -compare-lessequal-14-arg2 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-lessequal-14-sub 
        Subtract                               
        JumpPos      -compare-lessequal-14-false 
        Jump         -compare-lessequal-14-true 
        Label        -compare-lessequal-14-true 
        PushI        1                         
        Jump         -compare-lessequal-14-join 
        Label        -compare-lessequal-14-false 
        PushI        0                         
        Jump         -compare-lessequal-14-join 
        Label        -compare-lessequal-14-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-15-arg1 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-lessequal-15-arg2 
        PushI        1                         
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
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-16-arg1 
        PushI        97                        
        ConvertF                               
        Label        -compare-lessequal-16-arg2 
        PushF        2.200000                  
        Label        -compare-lessequal-16-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-16-false 
        Jump         -compare-lessequal-16-true 
        Label        -compare-lessequal-16-true 
        PushI        1                         
        Jump         -compare-lessequal-16-join 
        Label        -compare-lessequal-16-false 
        PushI        0                         
        Jump         -compare-lessequal-16-join 
        Label        -compare-lessequal-16-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-17-arg1 
        PushF        2.200000                  
        Label        -compare-lessequal-17-arg2 
        PushI        97                        
        ConvertF                               
        Label        -compare-lessequal-17-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-17-false 
        Jump         -compare-lessequal-17-true 
        Label        -compare-lessequal-17-true 
        PushI        1                         
        Jump         -compare-lessequal-17-join 
        Label        -compare-lessequal-17-false 
        PushI        0                         
        Jump         -compare-lessequal-17-join 
        Label        -compare-lessequal-17-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-lessequal-18-arg1 
        PushI        2                         
        ConvertF                               
        Label        -compare-lessequal-18-arg2 
        PushF        2.200000                  
        Label        -compare-lessequal-18-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-18-false 
        Jump         -compare-lessequal-18-true 
        Label        -compare-lessequal-18-true 
        PushI        1                         
        Jump         -compare-lessequal-18-join 
        Label        -compare-lessequal-18-false 
        PushI        0                         
        Jump         -compare-lessequal-18-join 
        Label        -compare-lessequal-18-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-lessequal-19-arg1 
        PushF        2.200000                  
        Label        -compare-lessequal-19-arg2 
        PushI        2                         
        ConvertF                               
        Label        -compare-lessequal-19-sub 
        FSubtract                              
        JumpFPos     -compare-lessequal-19-false 
        Jump         -compare-lessequal-19-true 
        Label        -compare-lessequal-19-true 
        PushI        1                         
        Jump         -compare-lessequal-19-join 
        Label        -compare-lessequal-19-false 
        PushI        0                         
        Jump         -compare-lessequal-19-join 
        Label        -compare-lessequal-19-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greater-20-arg1  
        PushI        1                         
        Label        -compare-greater-20-arg2  
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-greater-20-sub   
        Subtract                               
        JumpPos      -compare-greater-20-true  
        Jump         -compare-greater-20-false 
        Label        -compare-greater-20-true  
        PushI        1                         
        Jump         -compare-greater-20-join  
        Label        -compare-greater-20-false 
        PushI        0                         
        Jump         -compare-greater-20-join  
        Label        -compare-greater-20-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-21-arg1  
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-greater-21-arg2  
        PushI        1                         
        Label        -compare-greater-21-sub   
        Subtract                               
        JumpPos      -compare-greater-21-true  
        Jump         -compare-greater-21-false 
        Label        -compare-greater-21-true  
        PushI        1                         
        Jump         -compare-greater-21-join  
        Label        -compare-greater-21-false 
        PushI        0                         
        Jump         -compare-greater-21-join  
        Label        -compare-greater-21-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greater-22-arg1  
        PushI        97                        
        ConvertF                               
        Label        -compare-greater-22-arg2  
        PushF        2.200000                  
        Label        -compare-greater-22-sub   
        FSubtract                              
        JumpFPos     -compare-greater-22-true  
        Jump         -compare-greater-22-false 
        Label        -compare-greater-22-true  
        PushI        1                         
        Jump         -compare-greater-22-join  
        Label        -compare-greater-22-false 
        PushI        0                         
        Jump         -compare-greater-22-join  
        Label        -compare-greater-22-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greater-23-arg1  
        PushF        2.200000                  
        Label        -compare-greater-23-arg2  
        PushI        97                        
        ConvertF                               
        Label        -compare-greater-23-sub   
        FSubtract                              
        JumpFPos     -compare-greater-23-true  
        Jump         -compare-greater-23-false 
        Label        -compare-greater-23-true  
        PushI        1                         
        Jump         -compare-greater-23-join  
        Label        -compare-greater-23-false 
        PushI        0                         
        Jump         -compare-greater-23-join  
        Label        -compare-greater-23-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greater-24-arg1  
        PushI        2                         
        ConvertF                               
        Label        -compare-greater-24-arg2  
        PushF        2.200000                  
        Label        -compare-greater-24-sub   
        FSubtract                              
        JumpFPos     -compare-greater-24-true  
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
        Label        -compare-greater-25-arg1  
        PushF        2.200000                  
        Label        -compare-greater-25-arg2  
        PushI        2                         
        ConvertF                               
        Label        -compare-greater-25-sub   
        FSubtract                              
        JumpFPos     -compare-greater-25-true  
        Jump         -compare-greater-25-false 
        Label        -compare-greater-25-true  
        PushI        1                         
        Jump         -compare-greater-25-join  
        Label        -compare-greater-25-false 
        PushI        0                         
        Jump         -compare-greater-25-join  
        Label        -compare-greater-25-join  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greaterequal-26-arg1 
        PushI        1                         
        Label        -compare-greaterequal-26-arg2 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-greaterequal-26-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-26-false 
        Jump         -compare-greaterequal-26-true 
        Label        -compare-greaterequal-26-true 
        PushI        1                         
        Jump         -compare-greaterequal-26-join 
        Label        -compare-greaterequal-26-false 
        PushI        0                         
        Jump         -compare-greaterequal-26-join 
        Label        -compare-greaterequal-26-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-27-arg1 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-greaterequal-27-arg2 
        PushI        1                         
        Label        -compare-greaterequal-27-sub 
        Subtract                               
        JumpNeg      -compare-greaterequal-27-false 
        Jump         -compare-greaterequal-27-true 
        Label        -compare-greaterequal-27-true 
        PushI        1                         
        Jump         -compare-greaterequal-27-join 
        Label        -compare-greaterequal-27-false 
        PushI        0                         
        Jump         -compare-greaterequal-27-join 
        Label        -compare-greaterequal-27-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greaterequal-28-arg1 
        PushI        97                        
        ConvertF                               
        Label        -compare-greaterequal-28-arg2 
        PushF        2.200000                  
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
        Label        -compare-greaterequal-29-arg1 
        PushF        2.200000                  
        Label        -compare-greaterequal-29-arg2 
        PushI        97                        
        ConvertF                               
        Label        -compare-greaterequal-29-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-29-false 
        Jump         -compare-greaterequal-29-true 
        Label        -compare-greaterequal-29-true 
        PushI        1                         
        Jump         -compare-greaterequal-29-join 
        Label        -compare-greaterequal-29-false 
        PushI        0                         
        Jump         -compare-greaterequal-29-join 
        Label        -compare-greaterequal-29-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-greaterequal-30-arg1 
        PushI        2                         
        ConvertF                               
        Label        -compare-greaterequal-30-arg2 
        PushF        2.200000                  
        Label        -compare-greaterequal-30-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-30-false 
        Jump         -compare-greaterequal-30-true 
        Label        -compare-greaterequal-30-true 
        PushI        1                         
        Jump         -compare-greaterequal-30-join 
        Label        -compare-greaterequal-30-false 
        PushI        0                         
        Jump         -compare-greaterequal-30-join 
        Label        -compare-greaterequal-30-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-greaterequal-31-arg1 
        PushF        2.200000                  
        Label        -compare-greaterequal-31-arg2 
        PushI        2                         
        ConvertF                               
        Label        -compare-greaterequal-31-sub 
        FSubtract                              
        JumpFNeg     -compare-greaterequal-31-false 
        Jump         -compare-greaterequal-31-true 
        Label        -compare-greaterequal-31-true 
        PushI        1                         
        Jump         -compare-greaterequal-31-join 
        Label        -compare-greaterequal-31-false 
        PushI        0                         
        Jump         -compare-greaterequal-31-join 
        Label        -compare-greaterequal-31-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-notequal-32-arg1 
        PushI        1                         
        Label        -compare-notequal-32-arg2 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-notequal-32-sub  
        Subtract                               
        JumpTrue     -compare-notequal-32-true 
        Jump         -compare-notequal-32-false 
        Label        -compare-notequal-32-true 
        PushI        1                         
        Jump         -compare-notequal-32-join 
        Label        -compare-notequal-32-false 
        PushI        0                         
        Jump         -compare-notequal-32-join 
        Label        -compare-notequal-32-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-33-arg1 
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-notequal-33-arg2 
        PushI        1                         
        Label        -compare-notequal-33-sub  
        Subtract                               
        JumpTrue     -compare-notequal-33-true 
        Jump         -compare-notequal-33-false 
        Label        -compare-notequal-33-true 
        PushI        1                         
        Jump         -compare-notequal-33-join 
        Label        -compare-notequal-33-false 
        PushI        0                         
        Jump         -compare-notequal-33-join 
        Label        -compare-notequal-33-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-notequal-34-arg1 
        PushI        97                        
        ConvertF                               
        Label        -compare-notequal-34-arg2 
        PushF        2.200000                  
        Label        -compare-notequal-34-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-34-false 
        Jump         -compare-notequal-34-true 
        Label        -compare-notequal-34-false 
        PushI        0                         
        Jump         -compare-notequal-34-join 
        Label        -compare-notequal-34-true 
        PushI        1                         
        Jump         -compare-notequal-34-join 
        Label        -compare-notequal-34-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-35-arg1 
        PushF        2.200000                  
        Label        -compare-notequal-35-arg2 
        PushI        97                        
        ConvertF                               
        Label        -compare-notequal-35-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-35-false 
        Jump         -compare-notequal-35-true 
        Label        -compare-notequal-35-false 
        PushI        0                         
        Jump         -compare-notequal-35-join 
        Label        -compare-notequal-35-true 
        PushI        1                         
        Jump         -compare-notequal-35-join 
        Label        -compare-notequal-35-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-notequal-36-arg1 
        PushI        2                         
        ConvertF                               
        Label        -compare-notequal-36-arg2 
        PushF        2.200000                  
        Label        -compare-notequal-36-sub  
        FSubtract                              
        JumpFZero    -compare-notequal-36-false 
        Jump         -compare-notequal-36-true 
        Label        -compare-notequal-36-false 
        PushI        0                         
        Jump         -compare-notequal-36-join 
        Label        -compare-notequal-36-true 
        PushI        1                         
        Jump         -compare-notequal-36-join 
        Label        -compare-notequal-36-join 
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-notequal-37-arg1 
        PushF        2.200000                  
        Label        -compare-notequal-37-arg2 
        PushI        2                         
        ConvertF                               
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
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-38-arg1    
        PushI        1                         
        Label        -compare-equal-38-arg2    
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-equal-38-sub     
        Subtract                               
        JumpFalse    -compare-equal-38-true    
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
        Label        -compare-equal-39-arg1    
        PushI        97                        
        PushI        255                       
        BTAnd                                  
        Label        -compare-equal-39-arg2    
        PushI        1                         
        Label        -compare-equal-39-sub     
        Subtract                               
        JumpFalse    -compare-equal-39-true    
        Jump         -compare-equal-39-false   
        Label        -compare-equal-39-true    
        PushI        1                         
        Jump         -compare-equal-39-join    
        Label        -compare-equal-39-false   
        PushI        0                         
        Jump         -compare-equal-39-join    
        Label        -compare-equal-39-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-40-arg1    
        PushI        97                        
        ConvertF                               
        Label        -compare-equal-40-arg2    
        PushF        2.200000                  
        Label        -compare-equal-40-sub     
        FSubtract                              
        JumpFZero    -compare-equal-40-true    
        Jump         -compare-equal-40-false   
        Label        -compare-equal-40-true    
        PushI        1                         
        Jump         -compare-equal-40-join    
        Label        -compare-equal-40-false   
        PushI        0                         
        Jump         -compare-equal-40-join    
        Label        -compare-equal-40-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-equal-41-arg1    
        PushF        2.200000                  
        Label        -compare-equal-41-arg2    
        PushI        97                        
        ConvertF                               
        Label        -compare-equal-41-sub     
        FSubtract                              
        JumpFZero    -compare-equal-41-true    
        Jump         -compare-equal-41-false   
        Label        -compare-equal-41-true    
        PushI        1                         
        Jump         -compare-equal-41-join    
        Label        -compare-equal-41-false   
        PushI        0                         
        Jump         -compare-equal-41-join    
        Label        -compare-equal-41-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Label        -compare-equal-42-arg1    
        PushI        2                         
        ConvertF                               
        Label        -compare-equal-42-arg2    
        PushF        2.200000                  
        Label        -compare-equal-42-sub     
        FSubtract                              
        JumpFZero    -compare-equal-42-true    
        Jump         -compare-equal-42-false   
        Label        -compare-equal-42-true    
        PushI        1                         
        Jump         -compare-equal-42-join    
        Label        -compare-equal-42-false   
        PushI        0                         
        Jump         -compare-equal-42-join    
        Label        -compare-equal-42-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-space       
        Printf                                 
        Label        -compare-equal-43-arg1    
        PushF        2.200000                  
        Label        -compare-equal-43-arg2    
        PushI        2                         
        ConvertF                               
        Label        -compare-equal-43-sub     
        FSubtract                              
        JumpFZero    -compare-equal-43-true    
        Jump         -compare-equal-43-false   
        Label        -compare-equal-43-true    
        PushI        1                         
        Jump         -compare-equal-43-join    
        Label        -compare-equal-43-false   
        PushI        0                         
        Jump         -compare-equal-43-join    
        Label        -compare-equal-43-join    
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        PushD        $print-format-newline     
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
