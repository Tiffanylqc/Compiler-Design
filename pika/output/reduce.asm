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
        DLabel       $null-string-runtime-error 
        DataC        110                       %% "null string"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        115                       
        DataC        116                       
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        0                         
        Label        $$null-string             
        PushD        $null-string-runtime-error 
        Jump         $$general-runtime-error   
        DLabel       $no-return                
        DataC        110                       %% "no return"
        DataC        111                       
        DataC        32                        
        DataC        114                       
        DataC        101                       
        DataC        116                       
        DataC        117                       
        DataC        114                       
        DataC        110                       
        DataC        0                         
        Label        $$no return               
        PushD        $no-return                
        Jump         $$general-runtime-error   
        DLabel       $string-slice-index-error 
        DataC        115                       %% "string slice index error"
        DataC        116                       
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        115                       
        DataC        108                       
        DataC        105                       
        DataC        99                        
        DataC        101                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $$string-slice-index-error 
        PushD        $string-slice-index-error 
        Jump         $$general-runtime-error   
        DLabel       $zip-array-length-different 
        DataC        122                       %% "zip array different error"
        DataC        105                       
        DataC        112                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        102                       
        DataC        102                       
        DataC        101                       
        DataC        114                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $zip-length-different     
        PushD        $zip-array-length-different 
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
        DLabel       $frame-pointer            
        DataZ        4                         
        DLabel       $stack-pointer            
        DataZ        4                         
        DLabel       $slice-string-index1      
        DataZ        4                         
        DLabel       $slice-string-index2      
        DataZ        4                         
        DLabel       $slice-string-address     
        DataZ        4                         
        DLabel       $string-element-temp1     
        DataZ        4                         
        DLabel       $string-element-temp2     
        DataZ        4                         
        DLabel       $string-length-temp       
        DataZ        4                         
        DLabel       $string-addr-temp1        
        DataZ        4                         
        DLabel       $string-addr-temp2        
        DataZ        4                         
        DLabel       $for-index                
        DataZ        4                         
        DLabel       $for-expression           
        DataZ        4                         
        DLabel       $for-length               
        DataZ        4                         
        DLabel       $for-subsize              
        DataZ        4                         
        DLabel       $for-identifier           
        DataZ        4                         
        DLabel       $array-address            
        DataZ        4                         
        DLabel       $lambda-address           
        DataZ        4                         
        DLabel       $array-element-temp2      
        DataZ        4                         
        DLabel       $array-address-S          
        DataZ        4                         
        DLabel       $array-address-T          
        DataZ        4                         
        DLabel       $array-element-temp3      
        DataZ        4                         
        DLabel       $param-u                  
        DataZ        4                         
        DLabel       $call-result              
        DataZ        4                         
        DLabel       $char-temp                
        DataZ        1                         
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
        JumpNeg      -lowest-term-subroutine-8-exchange 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Jump         -lowest-term-subroutine-8-loop-start 
        Label        -lowest-term-subroutine-8-exchange 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-numerator    
        LoadI                                  
        Label        -lowest-term-subroutine-8-loop-start 
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
        JumpFalse    -lowest-term-subroutine-8-end 
        Remainder                              
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Exchange                               
        Jump         -lowest-term-subroutine-8-loop-start 
        Label        -lowest-term-subroutine-8-end 
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
        Label        -clear-n-bytes-subroutine-9-loop-start 
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        JumpFalse    -clear-n-bytes-subroutine-9-end 
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
        Jump         -clear-n-bytes-subroutine-9-loop-start 
        Label        -clear-n-bytes-subroutine-9-end 
        PushD        $clear-n-bytes-return-address 
        LoadI                                  
        Return                                 
        Label        $print-array-subroutine   
        DLabel       -print-array-recursive-10-return-address 
        DataZ        4                         
        PushD        -print-array-recursive-10-return-address 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-10-type 
        DataZ        4                         
        PushD        -print-array-recursive-10-type 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-10-element 
        DataZ        4                         
        DLabel       -print-array-recursive-10-length 
        DataZ        4                         
        DLabel       -print-array-recursive-10-elem-size 
        DataZ        4                         
        DLabel       -print-array-recursive-10-array 
        DataZ        4                         
        Duplicate                              
        JumpFalse    $$null-array              
        Duplicate                              
        Duplicate                              
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -print-array-recursive-10-element 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-10-length 
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-10-elem-size 
        Exchange                               
        StoreI                                 
        PushD        $open-bracket-string      
        PushD        $print-format-string      
        Printf                                 
        Duplicate                              
        PushD        -print-array-recursive-10-array 
        Exchange                               
        StoreI                                 
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        2                         
        BTAnd                                  
        JumpFalse    -print-array-recursive-10-one-dim 
        Label        -print-array-recursive-10-loop-start 
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-10-end 
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-one-dim 
        PushD        -print-array-recursive-10-return-address 
        LoadI                                  
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        PushD        -print-array-recursive-10-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        LoadI                                  
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        Call         $print-array-subroutine   
        PushD        -print-array-recursive-10-elem-size 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-element 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-type 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-return-address 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-10-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-10-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-loop-start 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-10-loop-start 
        Label        -print-array-recursive-10-one-dim 
        Label        -print-array-recursive-10-loop-start-2 
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-10-end 
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-int-label 
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        2                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-float-label 
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        3                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-char-label 
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-string-label 
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        5                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-rat-label 
        PushD        -print-array-recursive-10-type 
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-bool-label 
        Label        -print-array-recursive-10-int-label 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-float-label 
        LoadF                                  
        PushD        $print-format-floating    
        Printf                                 
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-char-label 
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-rat-label 
        Duplicate                              
        LoadI                                  
        Exchange                               
        PushI        4                         
        Add                                    
        LoadI                                  
        Call         $print-rational           
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-bool-label 
        LoadC                                  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-string-label 
        LoadI                                  
        Call         $print-string             
        Jump         -print-array-recursive-10-join-label 
        Label        -print-array-recursive-10-join-label 
        PushD        -print-array-recursive-10-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-10-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-10-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-10-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-10-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-10-loop-start-2 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-10-loop-start-2 
        Label        -print-array-recursive-10-end 
        PushD        $close-bracket-string     
        PushD        $print-format-string      
        Printf                                 
        PushD        -print-array-recursive-10-return-address 
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
        JumpFalse    $$over-zero-denominator   
        Duplicate                              
        JumpPos      -print-rational-11-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-11-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-11-zero-numerator 
        JumpPos      -print-rational-11-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-11-numerator-pos 
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
        JumpPos      -print-rational-11-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-11-rational-pos 
        JumpFalse    -print-rational-11-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-11-fraction 
        JumpFalse    -print-rational-11-end    
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
        Jump         -print-rational-11-end    
        Label        -print-rational-11-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-11-end    
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
        JumpFalse    $$null-string             
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
        Label        -print-string-12-loop-start 
        PushD        $print-string-length      
        LoadI                                  
        JumpFalse    -print-string-12-end      
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
        Jump         -print-string-12-loop-start 
        Label        -print-string-12-end      
        PushD        $print-string-return-address 
        LoadI                                  
        Return                                 
        Label        $convert-to-string-if-bool-subroutine 
        DLabel       $convert-to-string-if-bool-return-address 
        DataZ        4                         
        PushD        $convert-to-string-if-bool-return-address 
        Exchange                               
        StoreI                                 
        JumpTrue     -print-boolean-13-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-13-join    
        Label        -print-boolean-13-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-13-join    
        PushD        $convert-to-string-if-bool-return-address 
        LoadI                                  
        Return                                 
        DLabel       -release-record-14-length 
        DataZ        4                         
        DLabel       -release-record-14-element-size 
        DataZ        4                         
        DLabel       -release-record-14-element 
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
        JumpTrue     -release-record-14-end    
        PushI        8                         
        BTAnd                                  
        JumpTrue     -release-record-14-end    
        PushI        2                         
        BTAnd                                  
        JumpFalse    -release-record-14-release 
        Duplicate                              
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -release-record-14-length 
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-14-element-size 
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        -release-record-14-element 
        Exchange                               
        StoreI                                 
        Jump         -release-record-14-join   
        Label        -release-record-14-string-record 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-14-length 
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        -release-record-14-element-size 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        PushD        -release-record-14-element 
        Exchange                               
        StoreI                                 
        Label        -release-record-14-join   
        Label        -release-record-14-loop-start 
        PushD        -release-record-14-length 
        LoadI                                  
        JumpFalse    -release-record-14-end    
        PushD        -release-record-14-element 
        LoadI                                  
        PushD        -release-record-14-length 
        LoadI                                  
        PushD        -release-record-14-element-size 
        LoadI                                  
        PushD        $release-record-return-address 
        LoadI                                  
        PushD        -release-record-14-element 
        LoadI                                  
        LoadI                                  
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -release-record-14-release 
        Call         $release-record           
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        PushD        -release-record-14-element-size 
        Exchange                               
        StoreI                                 
        PushD        -release-record-14-length 
        Exchange                               
        StoreI                                 
        PushD        -release-record-14-element 
        Exchange                               
        StoreI                                 
        PushD        -release-record-14-element-size 
        LoadI                                  
        PushD        -release-record-14-element 
        LoadI                                  
        Add                                    
        PushD        -release-record-14-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -release-record-14-length 
        LoadI                                  
        Add                                    
        PushD        -release-record-14-length 
        Exchange                               
        StoreI                                 
        Jump         -release-record-14-loop-start 
        Label        -release-record-14-release 
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
        Label        -release-record-14-end    
        PushD        $release-record-return-address 
        LoadI                                  
        Return                                 
        Label        $subtract-rational        
        DLabel       $subtract-rational-return-address 
        DataZ        4                         
        PushD        $subtract-rational-return-address 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $rational-denominator-temp2 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp2 
        LoadI                                  
        PushD        $rational-numerator-temp  
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $rational-numerator-temp2 
        LoadI                                  
        Multiply                               
        Subtract                               
        Exchange                               
        Call         $lowest-term-subroutine   
        PushD        $subtract-rational-return-address 
        LoadI                                  
        Return                                 
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        56                        
        Label        $$main                    
        Memtop                                 
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Memtop                                 
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% numbers
        PushI        4                         
        PushI        6                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-15-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        8                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        11                        
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        PushI        12                        
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-15-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-15-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% isOdd
        DLabel       -function-body-18-return-addr 
        DataZ        4                         
        Jump         -function-body-18--end    
        Label        -function-body-18--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Label        -compare-notequal-17-arg1 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        Label        -compare-notequal-17-arg2 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        PushI        2                         
        Duplicate                              
        JumpFalse    $$i-divide-by-zero        
        Divide                                 
        PushI        2                         
        Multiply                               
        Label        -compare-notequal-17-sub  
        Subtract                               
        JumpTrue     -compare-notequal-17-true 
        Jump         -compare-notequal-17-false 
        Label        -compare-notequal-17-true 
        PushI        1                         
        Jump         -compare-notequal-17-join 
        Label        -compare-notequal-17-false 
        PushI        0                         
        Jump         -compare-notequal-17-join 
        Label        -compare-notequal-17-join 
        Jump         -function-body-16--exit-handshake 
        Jump         $$no return               
        Label        -function-body-16--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-18-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        12                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-18-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-18--end    
        PushD        -function-body-18--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% a1
        PushI        4                         
        PushI        5                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-24-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-19-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-19-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-19-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-19-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-19-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-19-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-20-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-20-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-20-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-20-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        PushI        6                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-20-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-20-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-21-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-21-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        PushI        2                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-21-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        PushI        4                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-21-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        PushI        6                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-21-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-21-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-22-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-22-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-22-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        PushI        7                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-22-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        PushI        8                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-22-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-22-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        6                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-23-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        7                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        9                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        PushI        11                        
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-23-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-23-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-24-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-24-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% allOdd
        DLabel       -function-body-30-return-addr 
        DataZ        4                         
        Jump         -function-body-30--end    
        Label        -function-body-30--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -12                       
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        DLabel       -for-expr-29-for-length   
        DataZ        4                         
        DLabel       -for-expr-29-for-index    
        DataZ        4                         
        DLabel       -for-expr-29-for-expr     
        DataZ        4                         
        DLabel       -for-expr-29-for-subsize  
        DataZ        4                         
        DLabel       -for-expr-29-for-indentifier 
        DataZ        4                         
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        Duplicate                              
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -for-expr-29-for-expr     
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -for-expr-29-for-length   
        Exchange                               
        StoreI                                 
        PushD        -for-expr-29-for-expr     
        LoadI                                  
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -for-expr-29-for-subsize  
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -for-expr-29-for-index    
        Exchange                               
        StoreI                                 
        Label        -for-expr-29-loop-start   
        PushD        -for-expr-29-for-length   
        LoadI                                  
        PushD        -for-expr-29-for-index    
        LoadI                                  
        Subtract                               
        JumpPos      -for-expr-29-in-label     
        Jump         -for-expr-29-exit         
        Label        -for-expr-29-in-label     
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% i
        Duplicate                              
        PushD        -for-expr-29-for-indentifier 
        Exchange                               
        StoreI                                 
        PushD        -for-expr-29-for-expr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -for-expr-29-for-index    
        LoadI                                  
        PushD        -for-expr-29-for-subsize  
        LoadI                                  
        Multiply                               
        Add                                    
        PushD        -for-expr-29-for-subsize  
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpTrue     -for-expr-29-subsize-four 
        LoadC                                  
        StoreC                                 
        Jump         -for-expr-29-if-end       
        Label        -for-expr-29-subsize-four 
        PushD        -for-expr-29-for-subsize  
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpTrue     -for-expr-29-subsize-eight 
        LoadI                                  
        StoreI                                 
        Jump         -for-expr-29-if-end       
        Label        -for-expr-29-subsize-eight 
        LoadF                                  
        StoreF                                 
        Label        -for-expr-29-if-end       
        Label        -if-28-condition          
        Label        -compare-equal-27-arg1    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-27-arg2    
        PushI        1                         
        Label        -compare-equal-27-sub     
        Subtract                               
        JumpFalse    -compare-equal-27-true    
        Jump         -compare-equal-27-false   
        Label        -compare-equal-27-true    
        PushI        1                         
        Jump         -compare-equal-27-join    
        Label        -compare-equal-27-false   
        PushI        0                         
        Jump         -compare-equal-27-join    
        Label        -compare-equal-27-join    
        JumpTrue     -if-28-ifBody             
        Jump         -if-28-elseBody           
        Label        -if-28-ifBody             
        PushI        0                         
        Jump         -function-body-25--exit-handshake 
        Jump         -if-28-join               
        Label        -if-28-elseBody           
        Label        -if-28-join               
        PushI        1                         
        PushD        -for-expr-29-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-29-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-29-loop-start   
        Label        -for-elem-enter-26-break-target 
        Jump         -for-expr-29-exit         
        Label        -for-elem-enter-26-continue-target 
        PushI        1                         
        PushD        -for-expr-29-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-29-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-29-loop-start   
        Label        -for-expr-29-exit         
        PushI        1                         
        Jump         -function-body-25--exit-handshake 
        Jump         $$no return               
        Label        -function-body-25--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-30-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        16                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-30-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-30--end    
        PushD        -function-body-30--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% a2
        PushI        1                         
        PushI        6                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-31-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        0                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        PushI        0                         
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-31-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-31-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% f1
        DLabel       -function-body-33-return-addr 
        DataZ        4                         
        Jump         -function-body-33--end    
        Label        -function-body-33--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadC                                  
        Jump         -function-body-32--exit-handshake 
        Jump         $$no return               
        Label        -function-body-32--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-33-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-33-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-33--end    
        PushD        -function-body-33--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        24                        
        Add                                    %% a3
        PushI        4                         
        PushI        2                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-36-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-36-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-36-elemAddr 
        LoadI                                  
        PushI        1                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-34-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-34-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        PushI        105                       
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-34-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        PushI        97                        
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-34-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        PushI        109                       
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-34-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-34-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-36-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-36-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-36-elemAddr 
        LoadI                                  
        PushI        1                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-35-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-35-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        PushI        97                        
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-35-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        PushI        109                       
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-35-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        PushI        105                       
        StoreC                                 
        PushI        1                         
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-35-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-36-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-36-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        28                        
        Add                                    %% a4
        PushI        4                         
        PushI        2                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-45-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-45-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-45-elemAddr 
        LoadI                                  
        PushI        8                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        DLabel       -populate-creation-37-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-37-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushI        4                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-38-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-38-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-38-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-38-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-37-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushI        5                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-39-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-39-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-39-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-39-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-37-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        5                         
        PushI        6                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-40-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-40-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-40-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-40-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-37-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-37-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-45-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-45-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-45-elemAddr 
        LoadI                                  
        PushI        8                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        DLabel       -populate-creation-41-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-41-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        14                        
        PushI        13                        
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-42-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-42-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-42-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-42-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-41-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        14                        
        PushI        15                        
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-43-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-43-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-43-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-43-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-41-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        17                        
        PushI        16                        
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-44-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-44-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-44-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-44-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-41-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-41-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-45-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-45-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        32                        
        Add                                    %% f4
        DLabel       -function-body-56-return-addr 
        DataZ        4                         
        Jump         -function-body-56--end    
        Label        -function-body-56--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -24                       
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushI        1                         
        Call         $lowest-term-subroutine   
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% mul
        DLabel       -rational-storage-47-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-47-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-47-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-47-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        DLabel       -for-expr-52-for-length   
        DataZ        4                         
        DLabel       -for-expr-52-for-index    
        DataZ        4                         
        DLabel       -for-expr-52-for-expr     
        DataZ        4                         
        DLabel       -for-expr-52-for-subsize  
        DataZ        4                         
        DLabel       -for-expr-52-for-indentifier 
        DataZ        4                         
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        Duplicate                              
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -for-expr-52-for-expr     
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -for-expr-52-for-length   
        Exchange                               
        StoreI                                 
        PushD        -for-expr-52-for-expr     
        LoadI                                  
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -for-expr-52-for-subsize  
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -for-expr-52-for-index    
        Exchange                               
        StoreI                                 
        Label        -for-expr-52-loop-start   
        PushD        -for-expr-52-for-length   
        LoadI                                  
        PushD        -for-expr-52-for-index    
        LoadI                                  
        Subtract                               
        JumpPos      -for-expr-52-in-label     
        Jump         -for-expr-52-exit         
        Label        -for-expr-52-in-label     
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -24                       
        Add                                    %% i
        Duplicate                              
        PushD        -for-expr-52-for-indentifier 
        Exchange                               
        StoreI                                 
        PushD        -for-expr-52-for-expr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -for-expr-52-for-index    
        LoadI                                  
        PushD        -for-expr-52-for-subsize  
        LoadI                                  
        Multiply                               
        Add                                    
        PushD        -for-expr-52-for-subsize  
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpTrue     -for-expr-52-subsize-four 
        LoadC                                  
        StoreC                                 
        Jump         -for-expr-52-if-end       
        Label        -for-expr-52-subsize-four 
        PushD        -for-expr-52-for-subsize  
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpTrue     -for-expr-52-subsize-eight 
        LoadI                                  
        StoreI                                 
        Jump         -for-expr-52-if-end       
        Label        -for-expr-52-subsize-eight 
        LoadI                                  
        StoreI                                 
        PushD        -for-expr-52-for-indentifier 
        LoadI                                  
        PushI        4                         
        Add                                    
        PushD        -for-expr-52-for-expr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -for-expr-52-for-index    
        LoadI                                  
        PushD        -for-expr-52-for-subsize  
        LoadI                                  
        Multiply                               
        Add                                    
        PushI        4                         
        Add                                    
        LoadI                                  
        StoreI                                 
        Label        -for-expr-52-if-end       
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% mul
        Nop                                    
        DLabel       -rational-load-49-baseAddr 
        DataZ        4                         
        PushD        -rational-load-49-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-49-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-49-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -24                       
        Add                                    %% i
        Nop                                    
        DLabel       -rational-load-50-baseAddr 
        DataZ        4                         
        PushD        -rational-load-50-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-50-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-50-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        PushD        $rational-denominator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $rational-denominator-temp2 
        LoadI                                  
        Multiply                               
        PushD        $rational-numerator-temp2 
        LoadI                                  
        PushD        $rational-numerator-temp  
        LoadI                                  
        Multiply                               
        Exchange                               
        Call         $lowest-term-subroutine   
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% mul
        DLabel       -rational-storage-51-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-51-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-51-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-51-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        -for-expr-52-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-52-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-52-loop-start   
        Label        -for-elem-enter-48-break-target 
        Jump         -for-expr-52-exit         
        Label        -for-elem-enter-48-continue-target 
        PushI        1                         
        PushD        -for-expr-52-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-52-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-52-loop-start   
        Label        -for-expr-52-exit         
        Label        -if-55-condition          
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% mul
        Nop                                    
        DLabel       -rational-load-53-baseAddr 
        DataZ        4                         
        PushD        -rational-load-53-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-53-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-53-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        PushI        1                         
        PushI        2                         
        Call         $lowest-term-subroutine   
        Call         $subtract-rational        
        Pop                                    
        JumpFalse    -compare-equal-54-true    
        Jump         -compare-equal-54-false   
        Label        -compare-equal-54-true    
        PushI        1                         
        Jump         -compare-equal-54-join    
        Label        -compare-equal-54-false   
        PushI        0                         
        Jump         -compare-equal-54-join    
        Label        -compare-equal-54-join    
        JumpTrue     -if-55-ifBody             
        Jump         -if-55-elseBody           
        Label        -if-55-ifBody             
        PushI        1                         
        Jump         -function-body-46--exit-handshake 
        Jump         -if-55-join               
        Label        -if-55-elseBody           
        Label        -if-55-join               
        PushI        0                         
        Jump         -function-body-46--exit-handshake 
        Jump         $$no return               
        Label        -function-body-46--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-56-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        28                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-56-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-56--end    
        PushD        -function-body-56--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        36                        
        Add                                    %% f5
        DLabel       -function-body-61-return-addr 
        DataZ        4                         
        Jump         -function-body-61--end    
        Label        -function-body-61--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Label        -if-60-condition          
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        Nop                                    
        DLabel       -rational-load-58-baseAddr 
        DataZ        4                         
        PushD        -rational-load-58-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-58-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-58-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        PushI        1                         
        PushI        1                         
        Call         $subtract-rational        
        JumpNeg      -compare-greater-59-neg-denominator 
        JumpPos      -compare-greater-59-true  
        Jump         -compare-greater-59-false 
        Label        -compare-greater-59-neg-denominator 
        JumpNeg      -compare-greater-59-true  
        Jump         -compare-greater-59-false 
        Label        -compare-greater-59-true  
        PushI        1                         
        Jump         -compare-greater-59-join  
        Label        -compare-greater-59-false 
        PushI        0                         
        Jump         -compare-greater-59-join  
        Label        -compare-greater-59-join  
        JumpTrue     -if-60-ifBody             
        Jump         -if-60-elseBody           
        Label        -if-60-ifBody             
        PushI        1                         
        Jump         -function-body-57--exit-handshake 
        Jump         -if-60-join               
        Label        -if-60-elseBody           
        Label        -if-60-join               
        PushI        0                         
        Jump         -function-body-57--exit-handshake 
        Jump         $$no return               
        Label        -function-body-57--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-61-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        16                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-61-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-61--end    
        PushD        -function-body-61--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        40                        
        Add                                    %% a5
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-62-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-62-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        105                       
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
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-62-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        PushI        6                         
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
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
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
        PushI        101                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        99                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        110                       
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
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-62-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        104                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        105                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
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
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-62-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-62-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        44                        
        Add                                    %% a6
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-65-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-65-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        3                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        3                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-63-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-63-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        PushI        6                         
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
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        105                       
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
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        49                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-63-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        PushI        6                         
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
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        105                       
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
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        50                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-63-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        PushI        6                         
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
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        105                       
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
        PushI        115                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        116                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        51                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-63-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-63-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-65-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        PushD        $global-memory-block      
        PushI        40                        
        Add                                    %% a5
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-65-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        PushI        4                         
        PushI        4                         
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
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
        DLabel       -populate-creation-64-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-64-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        117                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        49                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-64-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        117                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        50                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-64-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        117                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        51                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-64-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        PushI        5                         
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
        PushI        5                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        102                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        117                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        52                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-64-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-64-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-65-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-65-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        48                        
        Add                                    %% pickL
        DLabel       -function-body-69-return-addr 
        DataZ        4                         
        Jump         -function-body-69--end    
        Label        -function-body-69--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Label        -if-68-condition          
        Label        -compare-equal-67-arg1    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-array              
        PushI        12                        
        Add                                    
        LoadI                                  
        Label        -compare-equal-67-arg2    
        PushI        3                         
        Label        -compare-equal-67-sub     
        Subtract                               
        JumpFalse    -compare-equal-67-true    
        Jump         -compare-equal-67-false   
        Label        -compare-equal-67-true    
        PushI        1                         
        Jump         -compare-equal-67-join    
        Label        -compare-equal-67-false   
        PushI        0                         
        Jump         -compare-equal-67-join    
        Label        -compare-equal-67-join    
        JumpTrue     -if-68-ifBody             
        Jump         -if-68-elseBody           
        Label        -if-68-ifBody             
        PushI        1                         
        Jump         -function-body-66--exit-handshake 
        Jump         -if-68-join               
        Label        -if-68-elseBody           
        Label        -if-68-join               
        PushI        0                         
        Jump         -function-body-66--exit-handshake 
        Jump         $$no return               
        Label        -function-body-66--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-69-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        12                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-69-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-69--end    
        PushD        -function-body-69--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        52                        
        Add                                    %% pickS
        DLabel       -function-body-73-return-addr 
        DataZ        4                         
        Jump         -function-body-73--end    
        Label        -function-body-73--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Label        -if-72-condition          
        Label        -compare-equal-71-arg1    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% x
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-string             
        PushI        8                         
        Add                                    
        LoadI                                  
        Label        -compare-equal-71-arg2    
        PushI        5                         
        Label        -compare-equal-71-sub     
        Subtract                               
        JumpFalse    -compare-equal-71-true    
        Jump         -compare-equal-71-false   
        Label        -compare-equal-71-true    
        PushI        1                         
        Jump         -compare-equal-71-join    
        Label        -compare-equal-71-false   
        PushI        0                         
        Jump         -compare-equal-71-join    
        Label        -compare-equal-71-join    
        JumpTrue     -if-72-ifBody             
        Jump         -if-72-elseBody           
        Label        -if-72-ifBody             
        PushI        1                         
        Jump         -function-body-70--exit-handshake 
        Jump         -if-72-join               
        Label        -if-72-elseBody           
        Label        -if-72-join               
        PushI        0                         
        Jump         -function-body-70--exit-handshake 
        Jump         $$no return               
        Label        -function-body-70--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-73-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        12                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -function-body-73-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-73--end    
        PushD        -function-body-73--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% numbers
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% isOdd
        LoadI                                  
        DLabel       -reduce-74-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-74-array-addr     
        DataZ        4                         
        DLabel       -reduce-74-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-74-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-74-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-74-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-74-reduce-count   
        DataZ        4                         
        PushD        -reduce-74-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-74-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-74-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-74-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-74-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-74-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-74-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-74-loop-start     
        PushD        -reduce-74-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-74-exit           
        PushD        -reduce-74-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        -4                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-74-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-74-false          
        PushI        1                         
        PushD        -reduce-74-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-74-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-74-array-element-temp 
        LoadI                                  
        LoadI                                  
        Label        -reduce-74-false          
        PushI        4                         
        PushD        -reduce-74-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-74-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-74-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-74-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-74-loop-start     
        Label        -reduce-74-exit           
        PushD        -reduce-74-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-74-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-74-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        4                         
        PushD        -reduce-74-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-74-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-74-loop-start2    
        PushD        -reduce-74-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-74-exit-2         
        PushD        -reduce-74-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-74-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-74-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -4                        
        PushD        -reduce-74-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-74-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-74-loop-start2    
        Label        -reduce-74-exit-2         
        PushD        -reduce-74-record-creation-temp 
        LoadI                                  
        PushI        1                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% a1
        LoadI                                  
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% allOdd
        LoadI                                  
        DLabel       -reduce-75-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-75-array-addr     
        DataZ        4                         
        DLabel       -reduce-75-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-75-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-75-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-75-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-75-reduce-count   
        DataZ        4                         
        PushD        -reduce-75-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-75-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-75-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-75-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-75-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-75-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-75-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-75-loop-start     
        PushD        -reduce-75-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-75-exit           
        PushD        -reduce-75-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        -4                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-75-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-75-false          
        PushI        1                         
        PushD        -reduce-75-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-75-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-75-array-element-temp 
        LoadI                                  
        LoadI                                  
        Label        -reduce-75-false          
        PushI        4                         
        PushD        -reduce-75-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-75-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-75-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-75-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-75-loop-start     
        Label        -reduce-75-exit           
        PushD        -reduce-75-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-75-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-75-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        4                         
        PushD        -reduce-75-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-75-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-75-loop-start2    
        PushD        -reduce-75-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-75-exit-2         
        PushD        -reduce-75-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-75-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-75-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -4                        
        PushD        -reduce-75-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-75-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-75-loop-start2    
        Label        -reduce-75-exit-2         
        PushD        -reduce-75-record-creation-temp 
        LoadI                                  
        PushI        1                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        44                        
        Add                                    %% a6
        LoadI                                  
        PushD        $global-memory-block      
        PushI        48                        
        Add                                    %% pickL
        LoadI                                  
        DLabel       -reduce-76-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-76-array-addr     
        DataZ        4                         
        DLabel       -reduce-76-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-76-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-76-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-76-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-76-reduce-count   
        DataZ        4                         
        PushD        -reduce-76-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-76-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-76-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-76-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-76-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-76-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-76-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-76-loop-start     
        PushD        -reduce-76-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-76-exit           
        PushD        -reduce-76-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        -4                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-76-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-76-false          
        PushI        1                         
        PushD        -reduce-76-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-76-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-76-array-element-temp 
        LoadI                                  
        LoadI                                  
        Label        -reduce-76-false          
        PushI        4                         
        PushD        -reduce-76-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-76-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-76-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-76-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-76-loop-start     
        Label        -reduce-76-exit           
        PushD        -reduce-76-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-76-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-76-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        4                         
        PushD        -reduce-76-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-76-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-76-loop-start2    
        PushD        -reduce-76-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-76-exit-2         
        PushD        -reduce-76-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-76-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-76-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -4                        
        PushD        -reduce-76-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-76-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-76-loop-start2    
        Label        -reduce-76-exit-2         
        PushD        -reduce-76-record-creation-temp 
        LoadI                                  
        PushI        4                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        40                        
        Add                                    %% a5
        LoadI                                  
        PushD        $global-memory-block      
        PushI        52                        
        Add                                    %% pickS
        LoadI                                  
        DLabel       -reduce-77-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-77-array-addr     
        DataZ        4                         
        DLabel       -reduce-77-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-77-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-77-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-77-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-77-reduce-count   
        DataZ        4                         
        PushD        -reduce-77-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-77-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-77-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-77-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-77-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-77-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-77-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-77-loop-start     
        PushD        -reduce-77-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-77-exit           
        PushD        -reduce-77-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        -4                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-77-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-77-false          
        PushI        1                         
        PushD        -reduce-77-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-77-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-77-array-element-temp 
        LoadI                                  
        LoadI                                  
        Label        -reduce-77-false          
        PushI        4                         
        PushD        -reduce-77-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-77-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-77-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-77-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-77-loop-start     
        Label        -reduce-77-exit           
        PushD        -reduce-77-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-77-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-77-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        4                         
        PushD        -reduce-77-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-77-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-77-loop-start2    
        PushD        -reduce-77-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-77-exit-2         
        PushD        -reduce-77-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-77-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-77-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -4                        
        PushD        -reduce-77-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-77-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-77-loop-start2    
        Label        -reduce-77-exit-2         
        PushD        -reduce-77-record-creation-temp 
        LoadI                                  
        PushI        4                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% a2
        LoadI                                  
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% f1
        LoadI                                  
        DLabel       -reduce-78-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-78-array-addr     
        DataZ        4                         
        DLabel       -reduce-78-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-78-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-78-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-78-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-78-reduce-count   
        DataZ        4                         
        PushD        -reduce-78-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-78-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-78-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-78-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-78-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-78-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-78-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-78-loop-start     
        PushD        -reduce-78-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-78-exit           
        PushD        -reduce-78-array-element-temp 
        LoadI                                  
        LoadC                                  
        PushI        -1                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushD        -reduce-78-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-78-false          
        PushI        1                         
        PushD        -reduce-78-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-78-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-78-array-element-temp 
        LoadI                                  
        LoadC                                  
        Label        -reduce-78-false          
        PushI        1                         
        PushD        -reduce-78-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-78-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-78-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-78-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-78-loop-start     
        Label        -reduce-78-exit           
        PushD        -reduce-78-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-78-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-78-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        1                         
        PushD        -reduce-78-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-78-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-78-loop-start2    
        PushD        -reduce-78-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-78-exit-2         
        PushD        -reduce-78-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushI        -1                        
        PushD        -reduce-78-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-78-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-78-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-78-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-78-loop-start2    
        Label        -reduce-78-exit-2         
        PushD        -reduce-78-record-creation-temp 
        LoadI                                  
        PushI        6                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        28                        
        Add                                    %% a4
        LoadI                                  
        PushD        $global-memory-block      
        PushI        32                        
        Add                                    %% f4
        LoadI                                  
        DLabel       -reduce-79-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-79-array-addr     
        DataZ        4                         
        DLabel       -reduce-79-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-79-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-79-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-79-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-79-reduce-count   
        DataZ        4                         
        PushD        -reduce-79-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-79-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-79-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-79-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-79-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-79-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-79-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-79-loop-start     
        PushD        -reduce-79-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-79-exit           
        PushD        -reduce-79-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        -4                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-79-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-79-false          
        PushI        1                         
        PushD        -reduce-79-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-79-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-79-array-element-temp 
        LoadI                                  
        LoadI                                  
        Label        -reduce-79-false          
        PushI        4                         
        PushD        -reduce-79-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-79-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-79-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-79-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-79-loop-start     
        Label        -reduce-79-exit           
        PushD        -reduce-79-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-79-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-79-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        4                         
        PushD        -reduce-79-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-79-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-79-loop-start2    
        PushD        -reduce-79-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-79-exit-2         
        PushD        -reduce-79-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-79-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-79-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -4                        
        PushD        -reduce-79-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-79-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-79-loop-start2    
        Label        -reduce-79-exit-2         
        PushD        -reduce-79-record-creation-temp 
        LoadI                                  
        PushI        5                         
        Call         $print-array-subroutine   
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        28                        
        Add                                    %% a4
        LoadI                                  
        PushI        1                         
        PushD        $a-indexing-index         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        LoadI                                  
        JumpFalse    $$null-array              
        PushD        $a-indexing-index         
        LoadI                                  
        JumpNeg      $$index-out-of-bound      
        PushD        $a-indexing-index         
        LoadI                                  
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Subtract                               
        JumpNeg      -array-indexing-80-in-bounds 
        Jump         $$index-out-of-bound      
        Label        -array-indexing-80-in-bounds 
        Nop                                    
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $a-indexing-index         
        LoadI                                  
        PushI        4                         
        Multiply                               
        Add                                    
        LoadI                                  
        PushD        $global-memory-block      
        PushI        36                        
        Add                                    %% f5
        LoadI                                  
        DLabel       -reduce-81-lambda-addr    
        DataZ        4                         
        DLabel       -reduce-81-array-addr     
        DataZ        4                         
        DLabel       -reduce-81-array-length-temp 
        DataZ        4                         
        DLabel       -reduce-81-record-creation-temp 
        DataZ        4                         
        DLabel       -reduce-81-array-element-temp 
        DataZ        4                         
        DLabel       -reduce-81-array-element-temp2 
        DataZ        4                         
        DLabel       -reduce-81-reduce-count   
        DataZ        4                         
        PushD        -reduce-81-lambda-addr    
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -reduce-81-array-addr     
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-array-addr     
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -reduce-81-array-length-temp 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -reduce-81-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-array-addr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -reduce-81-array-element-temp 
        Exchange                               
        StoreI                                 
        Label        -reduce-81-loop-start     
        PushD        -reduce-81-array-length-temp 
        LoadI                                  
        JumpFalse    -reduce-81-exit           
        PushD        -reduce-81-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -reduce-81-array-element-temp 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-lambda-addr    
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadC                                  
        PushI        1                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        JumpFalse    -reduce-81-false          
        PushI        1                         
        PushD        -reduce-81-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-81-reduce-count   
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -reduce-81-array-element-temp 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Label        -reduce-81-false          
        PushI        8                         
        PushD        -reduce-81-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-81-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-81-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -reduce-81-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -reduce-81-loop-start     
        Label        -reduce-81-exit           
        PushD        -reduce-81-reduce-count   
        LoadI                                  
        Duplicate                              
        JumpNeg      $$negative-length-array   
        Duplicate                              
        PushI        8                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $clear-n-bytes-subroutine 
        PushI        8                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-creation-temp     
        LoadI                                  
        PushD        -reduce-81-record-creation-temp 
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-record-creation-temp 
        LoadI                                  
        PushI        16                        
        Add                                    
        PushI        8                         
        PushD        -reduce-81-reduce-count   
        LoadI                                  
        PushI        1                         
        Subtract                               
        Multiply                               
        Add                                    
        PushD        -reduce-81-array-element-temp2 
        Exchange                               
        StoreI                                 
        Label        -reduce-81-loop-start2    
        PushD        -reduce-81-reduce-count   
        LoadI                                  
        JumpFalse    -reduce-81-exit-2         
        PushD        -reduce-81-array-element-temp2 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -reduce-81-array-element-temp2 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -reduce-81-reduce-count   
        LoadI                                  
        Add                                    
        PushD        -reduce-81-reduce-count   
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        -reduce-81-array-element-temp2 
        LoadI                                  
        Add                                    
        PushD        -reduce-81-array-element-temp2 
        Exchange                               
        StoreI                                 
        Jump         -reduce-81-loop-start2    
        Label        -reduce-81-exit-2         
        PushD        -reduce-81-record-creation-temp 
        LoadI                                  
        PushI        5                         
        Call         $print-array-subroutine   
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
