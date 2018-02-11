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
        DataC        122                       %% "zero denominator"
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
        DLabel       $rational-print-integer-part 
        DataZ        4                         
        DLabel       $rational-print-remainder 
        DataZ        4                         
        DLabel       $rational-print-sign      
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
        JumpNeg      -lowest-subroutine-1-exchange 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Jump         -lowest-subroutine-1-loop-start 
        Label        -lowest-subroutine-1-exchange 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-numerator    
        LoadI                                  
        Label        -lowest-subroutine-1-loop-start 
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
        JumpFalse    -lowest-subroutine-1-end  
        Remainder                              
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Exchange                               
        Jump         -lowest-subroutine-1-loop-start 
        Label        -lowest-subroutine-1-end  
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
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        24                        
        Label        $$main                    
        PushI        12                        
        PushI        8                         
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        DLabel       -rational-storage-2-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-2-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-2-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-2-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-3-baseAddr 
        DataZ        4                         
        PushD        -rational-load-3-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-3-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-3-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
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
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-5-baseAddr 
        DataZ        4                         
        PushD        -rational-load-5-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-5-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-5-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        8                         
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $express-over-denominator 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        DLabel       -rational-storage-6-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-6-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-6-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-6-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        Nop                                    
        DLabel       -rational-load-7-baseAddr 
        DataZ        4                         
        PushD        -rational-load-7-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-7-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-7-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-8-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-8-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-8-zero-numerator 
        JumpPos      -print-rational-8-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-8-numerator-pos 
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
        JumpPos      -print-rational-8-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-8-rational-pos 
        JumpFalse    -print-rational-8-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-8-fraction 
        JumpFalse    -print-rational-8-end     
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
        Jump         -print-rational-8-end     
        Label        -print-rational-8-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-8-end     
        PushD        $print-format-newline     
        Printf                                 
        PushI        -12                       
        PushI        8                         
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        DLabel       -rational-storage-9-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-9-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-9-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-9-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-10-baseAddr 
        DataZ        4                         
        PushD        -rational-load-10-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-10-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-10-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
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
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-12-baseAddr 
        DataZ        4                         
        PushD        -rational-load-12-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-12-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-12-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        8                         
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $express-over-denominator 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        DLabel       -rational-storage-13-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-13-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-13-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-13-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        Nop                                    
        DLabel       -rational-load-14-baseAddr 
        DataZ        4                         
        PushD        -rational-load-14-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-14-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-14-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-15-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-15-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-15-zero-numerator 
        JumpPos      -print-rational-15-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-15-numerator-pos 
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
        JumpPos      -print-rational-15-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-15-rational-pos 
        JumpFalse    -print-rational-15-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-15-fraction 
        JumpFalse    -print-rational-15-end    
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
        Jump         -print-rational-15-end    
        Label        -print-rational-15-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-15-end    
        PushD        $print-format-newline     
        Printf                                 
        PushI        12                        
        PushI        -8                        
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        DLabel       -rational-storage-16-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-16-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-16-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-16-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-17-baseAddr 
        DataZ        4                         
        PushD        -rational-load-17-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-17-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-17-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-18-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-18-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-18-zero-numerator 
        JumpPos      -print-rational-18-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-18-numerator-pos 
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
        JumpPos      -print-rational-18-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-18-rational-pos 
        JumpFalse    -print-rational-18-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-18-fraction 
        JumpFalse    -print-rational-18-end    
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
        Jump         -print-rational-18-end    
        Label        -print-rational-18-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-18-end    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        Nop                                    
        DLabel       -rational-load-19-baseAddr 
        DataZ        4                         
        PushD        -rational-load-19-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-19-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-19-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        8                         
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $express-over-denominator 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
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
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        Nop                                    
        DLabel       -rational-load-21-baseAddr 
        DataZ        4                         
        PushD        -rational-load-21-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-21-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-21-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-22-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-22-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-22-zero-numerator 
        JumpPos      -print-rational-22-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-22-numerator-pos 
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
        JumpPos      -print-rational-22-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-22-rational-pos 
        JumpFalse    -print-rational-22-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-22-fraction 
        JumpFalse    -print-rational-22-end    
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
        Jump         -print-rational-22-end    
        Label        -print-rational-22-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-22-end    
        PushD        $print-format-newline     
        Printf                                 
        PushI        -12                       
        PushI        -8                        
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
        DLabel       -rational-storage-23-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-23-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-23-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-23-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
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
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-25-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-25-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-25-zero-numerator 
        JumpPos      -print-rational-25-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-25-numerator-pos 
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
        JumpPos      -print-rational-25-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-25-rational-pos 
        JumpFalse    -print-rational-25-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-25-fraction 
        JumpFalse    -print-rational-25-end    
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
        Jump         -print-rational-25-end    
        Label        -print-rational-25-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-25-end    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% a
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
        PushI        -8                        
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $express-over-denominator 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        DLabel       -rational-storage-27-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-27-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-27-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-27-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        Nop                                    
        DLabel       -rational-load-28-baseAddr 
        DataZ        4                         
        PushD        -rational-load-28-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-28-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-28-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-29-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-29-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-29-zero-numerator 
        JumpPos      -print-rational-29-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-29-numerator-pos 
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
        JumpPos      -print-rational-29-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-29-rational-pos 
        JumpFalse    -print-rational-29-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-29-fraction 
        JumpFalse    -print-rational-29-end    
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
        Jump         -print-rational-29-end    
        Label        -print-rational-29-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-29-end    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% c
        PushF        1.678000                  
        StoreF                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% c
        LoadF                                  
        PushI        -2                        
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        Duplicate                              
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        ConvertF                               
        FMultiply                              
        ConvertI                               
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        DLabel       -rational-storage-30-baseAddr 
        DataZ        4                         
        PushD        -rational-storage-30-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-30-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        -rational-storage-30-baseAddr 
        LoadI                                  
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        Nop                                    
        DLabel       -rational-load-31-baseAddr 
        DataZ        4                         
        PushD        -rational-load-31-baseAddr 
        Exchange                               
        StoreI                                 
        PushD        -rational-load-31-baseAddr 
        LoadI                                  
        LoadI                                  
        PushD        -rational-load-31-baseAddr 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-32-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-32-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-32-zero-numerator 
        JumpPos      -print-rational-32-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-32-numerator-pos 
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
        JumpPos      -print-rational-32-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-32-rational-pos 
        JumpFalse    -print-rational-32-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-32-fraction 
        JumpFalse    -print-rational-32-end    
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
        Jump         -print-rational-32-end    
        Label        -print-rational-32-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-32-end    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% c
        LoadF                                  
        PushI        0                         
        Duplicate                              
        JumpFalse    $$rationalize-divide-by-zero 
        Duplicate                              
        PushD        $express-over-denominator 
        Exchange                               
        StoreI                                 
        ConvertF                               
        FMultiply                              
        ConvertI                               
        PushD        $express-over-denominator 
        LoadI                                  
        Call         $lowest-term-subroutine   
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpPos      -print-rational-33-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-33-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-33-zero-numerator 
        JumpPos      -print-rational-33-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-33-numerator-pos 
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
        JumpPos      -print-rational-33-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-33-rational-pos 
        JumpFalse    -print-rational-33-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-33-fraction 
        JumpFalse    -print-rational-33-end    
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
        Jump         -print-rational-33-end    
        Label        -print-rational-33-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-33-end    
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
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
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
