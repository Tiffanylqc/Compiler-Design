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
        DLabel       $fold-zero-length         
        DataC        102                       %% "fold-zero-length"
        DataC        111                       
        DataC        108                       
        DataC        100                       
        DataC        45                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        45                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        0                         
        Label        $$fold-zero-length        
        PushD        $fold-zero-length         
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
        JumpNeg      -lowest-term-subroutine-3-exchange 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Jump         -lowest-term-subroutine-3-loop-start 
        Label        -lowest-term-subroutine-3-exchange 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-numerator    
        LoadI                                  
        Label        -lowest-term-subroutine-3-loop-start 
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
        JumpFalse    -lowest-term-subroutine-3-end 
        Remainder                              
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Exchange                               
        Jump         -lowest-term-subroutine-3-loop-start 
        Label        -lowest-term-subroutine-3-end 
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
        Label        -clear-n-bytes-subroutine-4-loop-start 
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        JumpFalse    -clear-n-bytes-subroutine-4-end 
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
        Jump         -clear-n-bytes-subroutine-4-loop-start 
        Label        -clear-n-bytes-subroutine-4-end 
        PushD        $clear-n-bytes-return-address 
        LoadI                                  
        Return                                 
        Label        $print-array-subroutine   
        DLabel       -print-array-recursive-5-return-address 
        DataZ        4                         
        PushD        -print-array-recursive-5-return-address 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-5-type 
        DataZ        4                         
        PushD        -print-array-recursive-5-type 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-5-element 
        DataZ        4                         
        DLabel       -print-array-recursive-5-length 
        DataZ        4                         
        DLabel       -print-array-recursive-5-elem-size 
        DataZ        4                         
        DLabel       -print-array-recursive-5-array 
        DataZ        4                         
        Duplicate                              
        JumpFalse    $$null-array              
        Duplicate                              
        Duplicate                              
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-5-elem-size 
        Exchange                               
        StoreI                                 
        PushD        $open-bracket-string      
        PushD        $print-format-string      
        Printf                                 
        Duplicate                              
        PushD        -print-array-recursive-5-array 
        Exchange                               
        StoreI                                 
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        2                         
        BTAnd                                  
        JumpFalse    -print-array-recursive-5-one-dim 
        Label        -print-array-recursive-5-loop-start 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-5-end 
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-one-dim 
        PushD        -print-array-recursive-5-return-address 
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        Call         $print-array-subroutine   
        PushD        -print-array-recursive-5-elem-size 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-type 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-return-address 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-loop-start 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-5-loop-start 
        Label        -print-array-recursive-5-one-dim 
        Label        -print-array-recursive-5-loop-start-2 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-5-end 
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-int-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        2                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-float-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        3                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-char-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-string-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        5                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-rat-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-bool-label 
        Label        -print-array-recursive-5-int-label 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-float-label 
        LoadF                                  
        PushD        $print-format-floating    
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-char-label 
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-rat-label 
        Duplicate                              
        LoadI                                  
        Exchange                               
        PushI        4                         
        Add                                    
        LoadI                                  
        Call         $print-rational           
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-bool-label 
        LoadC                                  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-string-label 
        LoadI                                  
        Call         $print-string             
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-join-label 
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-loop-start-2 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-5-loop-start-2 
        Label        -print-array-recursive-5-end 
        PushD        $close-bracket-string     
        PushD        $print-format-string      
        Printf                                 
        PushD        -print-array-recursive-5-return-address 
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
        JumpPos      -print-rational-6-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-6-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-6-zero-numerator 
        JumpPos      -print-rational-6-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-6-numerator-pos 
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
        JumpPos      -print-rational-6-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-6-rational-pos 
        JumpFalse    -print-rational-6-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-6-fraction 
        JumpFalse    -print-rational-6-end     
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
        Jump         -print-rational-6-end     
        Label        -print-rational-6-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-6-end     
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
        Label        -print-string-7-loop-start 
        PushD        $print-string-length      
        LoadI                                  
        JumpFalse    -print-string-7-end       
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
        Jump         -print-string-7-loop-start 
        Label        -print-string-7-end       
        PushD        $print-string-return-address 
        LoadI                                  
        Return                                 
        Label        $convert-to-string-if-bool-subroutine 
        DLabel       $convert-to-string-if-bool-return-address 
        DataZ        4                         
        PushD        $convert-to-string-if-bool-return-address 
        Exchange                               
        StoreI                                 
        JumpTrue     -print-boolean-8-true     
        PushD        $boolean-false-string     
        Jump         -print-boolean-8-join     
        Label        -print-boolean-8-true     
        PushD        $boolean-true-string      
        Label        -print-boolean-8-join     
        PushD        $convert-to-string-if-bool-return-address 
        LoadI                                  
        Return                                 
        DLabel       -release-record-9-length  
        DataZ        4                         
        DLabel       -release-record-9-element-size 
        DataZ        4                         
        DLabel       -release-record-9-element 
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
        JumpTrue     -release-record-9-end     
        PushI        8                         
        BTAnd                                  
        JumpTrue     -release-record-9-end     
        PushI        2                         
        BTAnd                                  
        JumpFalse    -release-record-9-release 
        Duplicate                              
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        Jump         -release-record-9-join    
        Label        -release-record-9-string-record 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        Label        -release-record-9-join    
        Label        -release-record-9-loop-start 
        PushD        -release-record-9-length  
        LoadI                                  
        JumpFalse    -release-record-9-end     
        PushD        -release-record-9-element 
        LoadI                                  
        PushD        -release-record-9-length  
        LoadI                                  
        PushD        -release-record-9-element-size 
        LoadI                                  
        PushD        $release-record-return-address 
        LoadI                                  
        PushD        -release-record-9-element 
        LoadI                                  
        LoadI                                  
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -release-record-9-release 
        Call         $release-record           
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element-size 
        LoadI                                  
        PushD        -release-record-9-element 
        LoadI                                  
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -release-record-9-length  
        LoadI                                  
        Add                                    
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        Jump         -release-record-9-loop-start 
        Label        -release-record-9-release 
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
        Label        -release-record-9-end     
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
        DataZ        36                        
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
        PushI        0                         
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
        DLabel       -populate-creation-10-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        PushI        9                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        PushI        2                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-10-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-10-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% max
        DLabel       -function-body-14-return-addr 
        DataZ        4                         
        Jump         -function-body-14--end    
        Label        -function-body-14--anonymous-start 
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
        Label        -if-13-condition          
        Label        -compare-greater-12-arg1  
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Add                                    %% x
        LoadI                                  
        Label        -compare-greater-12-arg2  
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% y
        LoadI                                  
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
        JumpTrue     -if-13-ifBody             
        Jump         -if-13-elseBody           
        Label        -if-13-ifBody             
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Add                                    %% x
        LoadI                                  
        Jump         -function-body-11--exit-handshake 
        Jump         -if-13-join               
        Label        -if-13-elseBody           
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% y
        LoadI                                  
        Jump         -function-body-11--exit-handshake 
        Label        -if-13-join               
        Jump         $$no return               
        Label        -function-body-11--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-14-return-addr 
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
        PushD        -function-body-14-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-14--end    
        PushD        -function-body-14--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% maxity
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% numbers
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% max
        LoadI                                  
        DLabel       -zip-15-lambda-addr       
        DataZ        4                         
        DLabel       -zip-15-array-addr        
        DataZ        4                         
        DLabel       -zip-15-array-length-temp 
        DataZ        4                         
        DLabel       -zip-15-record-creation-temp 
        DataZ        4                         
        DLabel       -zip-15-array-element-temp 
        DataZ        4                         
        DLabel       -zip-15-array-element-temp2 
        DataZ        4                         
        DLabel       -zip-15-reduce-count      
        DataZ        4                         
        PushD        -zip-15-lambda-addr       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -zip-15-array-addr        
        Exchange                               
        StoreI                                 
        PushD        -zip-15-array-addr        
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$fold-zero-length        
        PushD        -zip-15-array-length-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-15-array-addr        
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -zip-15-array-element-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-15-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        4                         
        PushD        -zip-15-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-15-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-15-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-15-array-length-temp 
        Exchange                               
        StoreI                                 
        Label        -zip-15-loop-start        
        PushD        -zip-15-array-length-temp 
        LoadI                                  
        JumpFalse    -zip-15-exit              
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
        PushD        -zip-15-array-element-temp 
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
        PushD        -zip-15-lambda-addr       
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadI                                  
        PushI        4                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        -zip-15-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-15-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-15-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-15-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -zip-15-loop-start        
        Label        -zip-15-exit              
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% maxity
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% rats
        PushI        8                         
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
        PushI        0                         
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
        PushI        8                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        DLabel       -populate-creation-16-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        2                         
        PushI        1                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-17-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-17-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-17-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-17-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushI        3                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-18-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-18-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-18-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-18-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushI        7                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-19-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-19-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-19-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-19-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushI        16                        
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-20-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-20-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-20-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-20-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        1                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-21-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-21-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-21-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-21-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-16-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-16-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% minRat
        DLabel       -function-body-29-return-addr 
        DataZ        4                         
        Jump         -function-body-29--end    
        Label        -function-body-29--anonymous-start 
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
        Label        -if-28-condition          
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Add                                    %% x
        Nop                                    
        DLabel       -rational-load-23-baseAddr 
        DataZ        4                         
        PushD        -rational-load-23-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-23-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-23-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% y
        Nop                                    
        DLabel       -rational-load-24-baseAddr 
        DataZ        4                         
        PushD        -rational-load-24-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-24-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-24-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Call         $subtract-rational        
        JumpNeg      -compare-less-25-neg-denominator 
        JumpNeg      -compare-less-25-true     
        Jump         -compare-less-25-false    
        Label        -compare-less-25-neg-denominator 
        JumpPos      -compare-less-25-true     
        Jump         -compare-less-25-false    
        Label        -compare-less-25-true     
        PushI        1                         
        Jump         -compare-less-25-join     
        Label        -compare-less-25-false    
        PushI        0                         
        Jump         -compare-less-25-join     
        Label        -compare-less-25-join     
        JumpTrue     -if-28-ifBody             
        Jump         -if-28-elseBody           
        Label        -if-28-ifBody             
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Add                                    %% x
        Nop                                    
        DLabel       -rational-load-26-baseAddr 
        DataZ        4                         
        PushD        -rational-load-26-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-26-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-26-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Jump         -function-body-22--exit-handshake 
        Jump         -if-28-join               
        Label        -if-28-elseBody           
        PushD        $frame-pointer            
        LoadI                                  
        PushI        0                         
        Add                                    %% y
        Nop                                    
        DLabel       -rational-load-27-baseAddr 
        DataZ        4                         
        PushD        -rational-load-27-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-27-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-27-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Jump         -function-body-22--exit-handshake 
        Label        -if-28-join               
        Jump         $$no return               
        Label        -function-body-22--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-29-return-addr 
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
        PushI        24                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        -8                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Exchange                               
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
        PushD        -function-body-29-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-29--end    
        PushD        -function-body-29--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% rats
        LoadI                                  
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% minRat
        LoadI                                  
        DLabel       -zip-30-lambda-addr       
        DataZ        4                         
        DLabel       -zip-30-array-addr        
        DataZ        4                         
        DLabel       -zip-30-array-length-temp 
        DataZ        4                         
        DLabel       -zip-30-record-creation-temp 
        DataZ        4                         
        DLabel       -zip-30-array-element-temp 
        DataZ        4                         
        DLabel       -zip-30-array-element-temp2 
        DataZ        4                         
        DLabel       -zip-30-reduce-count      
        DataZ        4                         
        PushD        -zip-30-lambda-addr       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -zip-30-array-addr        
        Exchange                               
        StoreI                                 
        PushD        -zip-30-array-addr        
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$fold-zero-length        
        PushD        -zip-30-array-length-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-30-array-addr        
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -zip-30-array-element-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-30-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -zip-30-array-element-temp 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        8                         
        PushD        -zip-30-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-30-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-30-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-30-array-length-temp 
        Exchange                               
        StoreI                                 
        Label        -zip-30-loop-start        
        PushD        -zip-30-array-length-temp 
        LoadI                                  
        JumpFalse    -zip-30-exit              
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
        PushD        -zip-30-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -zip-30-array-element-temp 
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
        PushD        -zip-30-lambda-addr       
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadI                                  
        PushI        8                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -zip-30-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-30-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-30-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-30-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -zip-30-loop-start        
        Label        -zip-30-exit              
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% minityRat
        DLabel       -rational-storage-31-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-31-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-31-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-31-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% minityRat
        Nop                                    
        DLabel       -rational-load-32-baseAddr 
        DataZ        4                         
        PushD        -rational-load-32-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-32-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-32-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Call         $print-rational           
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        28                        
        Add                                    %% len1_int
        PushI        4                         
        PushI        1                         
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
        PushI        1                         
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
        DLabel       -populate-creation-33-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-33-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-33-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-33-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-33-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% maxity
        PushD        $global-memory-block      
        PushI        28                        
        Add                                    %% len1_int
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% max
        LoadI                                  
        DLabel       -zip-34-lambda-addr       
        DataZ        4                         
        DLabel       -zip-34-array-addr        
        DataZ        4                         
        DLabel       -zip-34-array-length-temp 
        DataZ        4                         
        DLabel       -zip-34-record-creation-temp 
        DataZ        4                         
        DLabel       -zip-34-array-element-temp 
        DataZ        4                         
        DLabel       -zip-34-array-element-temp2 
        DataZ        4                         
        DLabel       -zip-34-reduce-count      
        DataZ        4                         
        PushD        -zip-34-lambda-addr       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -zip-34-array-addr        
        Exchange                               
        StoreI                                 
        PushD        -zip-34-array-addr        
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$fold-zero-length        
        PushD        -zip-34-array-length-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-34-array-addr        
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -zip-34-array-element-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-34-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushI        4                         
        PushD        -zip-34-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-34-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-34-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-34-array-length-temp 
        Exchange                               
        StoreI                                 
        Label        -zip-34-loop-start        
        PushD        -zip-34-array-length-temp 
        LoadI                                  
        JumpFalse    -zip-34-exit              
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
        PushD        -zip-34-array-element-temp 
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
        PushD        -zip-34-lambda-addr       
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadI                                  
        PushI        4                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        -zip-34-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-34-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-34-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-34-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -zip-34-loop-start        
        Label        -zip-34-exit              
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% maxity
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        32                        
        Add                                    %% len1_rat
        PushI        8                         
        PushI        1                         
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
        PushI        1                         
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
        PushI        1                         
        PushI        2                         
        Call         $lowest-term-subroutine   
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        DLabel       -rational-storage-36-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-36-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-36-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-36-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -populate-creation-35-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-35-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        32                        
        Add                                    %% len1_rat
        LoadI                                  
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% minRat
        LoadI                                  
        DLabel       -zip-37-lambda-addr       
        DataZ        4                         
        DLabel       -zip-37-array-addr        
        DataZ        4                         
        DLabel       -zip-37-array-length-temp 
        DataZ        4                         
        DLabel       -zip-37-record-creation-temp 
        DataZ        4                         
        DLabel       -zip-37-array-element-temp 
        DataZ        4                         
        DLabel       -zip-37-array-element-temp2 
        DataZ        4                         
        DLabel       -zip-37-reduce-count      
        DataZ        4                         
        PushD        -zip-37-lambda-addr       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -zip-37-array-addr        
        Exchange                               
        StoreI                                 
        PushD        -zip-37-array-addr        
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$fold-zero-length        
        PushD        -zip-37-array-length-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-37-array-addr        
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -zip-37-array-element-temp 
        Exchange                               
        StoreI                                 
        PushD        -zip-37-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -zip-37-array-element-temp 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        8                         
        PushD        -zip-37-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-37-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-37-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-37-array-length-temp 
        Exchange                               
        StoreI                                 
        Label        -zip-37-loop-start        
        PushD        -zip-37-array-length-temp 
        LoadI                                  
        JumpFalse    -zip-37-exit              
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
        PushD        -zip-37-array-element-temp 
        LoadI                                  
        LoadI                                  
        PushD        -zip-37-array-element-temp 
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
        PushD        -zip-37-lambda-addr       
        LoadI                                  
        CallV                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        LoadI                                  
        PushI        8                         
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushI        8                         
        PushD        -zip-37-array-element-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-37-array-element-temp 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -zip-37-array-length-temp 
        LoadI                                  
        Add                                    
        PushD        -zip-37-array-length-temp 
        Exchange                               
        StoreI                                 
        Jump         -zip-37-loop-start        
        Label        -zip-37-exit              
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% minityRat
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
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% minityRat
        Nop                                    
        DLabel       -rational-load-39-baseAddr 
        DataZ        4                         
        PushD        -rational-load-39-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-39-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-39-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Call         $print-rational           
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
