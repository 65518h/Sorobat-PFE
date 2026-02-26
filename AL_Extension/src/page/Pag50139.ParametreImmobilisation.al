Page 50139 "Parametre Immobilisation"
{
    PageType = List;
    SourceTable = "FA Depreciation Book";
    ApplicationArea = all;
    Caption = 'Parametre Immobilisation';
    layout
    {
        area(content)
        {
            repeater(Control1100267000)
            {
                ShowCaption = false;
                Editable = false;
                field("FA No."; REC."FA No.")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Book Code"; REC."Depreciation Book Code")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Method"; REC."Depreciation Method")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Starting Date"; REC."Depreciation Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Straight-Line %"; REC."Straight-Line %")
                {
                    ApplicationArea = all;
                }
                field("No. of Depreciation Years"; REC."No. of Depreciation Years")
                {
                    ApplicationArea = all;
                }
                field("No. of Depreciation Months"; REC."No. of Depreciation Months")
                {
                    ApplicationArea = all;
                }
                field("Fixed Depr. Amount"; REC."Fixed Depr. Amount")
                {
                    ApplicationArea = all;
                }
                field("Declining-Balance %"; REC."Declining-Balance %")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Table Code"; REC."Depreciation Table Code")
                {
                    ApplicationArea = all;
                }
                field("Final Rounding Amount"; REC."Final Rounding Amount")
                {
                    ApplicationArea = all;
                }
                field("Ending Book Value"; REC."Ending Book Value")
                {
                    ApplicationArea = all;
                }
                field("FA Posting Group"; REC."FA Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Ending Date"; REC."Depreciation Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Acquisition Cost"; REC."Acquisition Cost")
                {
                    ApplicationArea = all;
                }
                field(Depreciation; REC.Depreciation)
                {
                    ApplicationArea = all;
                }
                field("Book Value"; REC."Book Value")
                {
                    ApplicationArea = all;
                }
                field("Proceeds on Disposal"; REC."Proceeds on Disposal")
                {
                    ApplicationArea = all;
                }
                field("Gain/Loss"; REC."Gain/Loss")
                {
                    ApplicationArea = all;
                }
                field("Write-Down"; REC."Write-Down")
                {
                    ApplicationArea = all;
                }
                field(Appreciation; REC.Appreciation)
                {
                    ApplicationArea = all;
                }
                field("Custom 1"; REC."Custom 1")
                {
                    ApplicationArea = all;
                }
                field("Custom 2"; REC."Custom 2")
                {
                    ApplicationArea = all;
                }
                field("Depreciable Basis"; REC."Depreciable Basis")
                {
                    ApplicationArea = all;
                }
                field("Salvage Value"; REC."Salvage Value")
                {
                    ApplicationArea = all;
                }
                field("Book Value on Disposal"; REC."Book Value on Disposal")
                {
                    ApplicationArea = all;
                }
                field(Maintenance; REC.Maintenance)
                {
                    ApplicationArea = all;
                }
                field("Maintenance Code Filter"; REC."Maintenance Code Filter")
                {
                    ApplicationArea = all;
                }
                field("FA Posting Date Filter"; REC."FA Posting Date Filter")
                {
                    ApplicationArea = all;
                }
                field("Acquisition Date"; REC."Acquisition Date")
                {
                    ApplicationArea = all;
                }
                field("G/L Acquisition Date"; REC."G/L Acquisition Date")
                {
                    ApplicationArea = all;
                }
                field("Disposal Date"; REC."Disposal Date")
                {
                    ApplicationArea = all;
                }
                field("Last Acquisition Cost Date"; REC."Last Acquisition Cost Date")
                {
                    ApplicationArea = all;
                }
                field("Last Depreciation Date"; REC."Last Depreciation Date")
                {
                    ApplicationArea = all;
                }
                field("Last Write-Down Date"; REC."Last Write-Down Date")
                {
                    ApplicationArea = all;
                }
                field("Last Appreciation Date"; REC."Last Appreciation Date")
                {
                    ApplicationArea = all;
                }
                field("Last Custom 1 Date"; REC."Last Custom 1 Date")
                {
                    ApplicationArea = all;
                }
                field("Last Custom 2 Date"; REC."Last Custom 2 Date")
                {
                    ApplicationArea = all;
                }
                field("Last Salvage Value Date"; REC."Last Salvage Value Date")
                {
                    ApplicationArea = all;
                }
                field("FA Exchange Rate"; REC."FA Exchange Rate")
                {
                    ApplicationArea = all;
                }
                field("Fixed Depr. Amount below Zero"; REC."Fixed Depr. Amount below Zero")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("First User-Defined Depr. Date"; REC."First User-Defined Depr. Date")
                {
                    ApplicationArea = all;
                }
                field("Use FA Ledger Check"; REC."Use FA Ledger Check")
                {
                    ApplicationArea = all;
                }
                field("Last Maintenance Date"; REC."Last Maintenance Date")
                {
                    ApplicationArea = all;
                }
                field("Depr. below Zero %"; REC."Depr. below Zero %")
                {
                    ApplicationArea = all;
                }
                field("Projected Disposal Date"; REC."Projected Disposal Date")
                {
                    ApplicationArea = all;
                }
                field("Projected Proceeds on Disposal"; REC."Projected Proceeds on Disposal")
                {
                    ApplicationArea = all;
                }
                field("Depr. Starting Date (Custom 1)"; REC."Depr. Starting Date (Custom 1)")
                {
                    ApplicationArea = all;
                }
                field("Depr. Ending Date (Custom 1)"; REC."Depr. Ending Date (Custom 1)")
                {
                    ApplicationArea = all;
                }
                field("Accum. Depr. % (Custom 1)"; REC."Accum. Depr. % (Custom 1)")
                {
                    ApplicationArea = all;
                }
                field("Depr. This Year % (Custom 1)"; REC."Depr. This Year % (Custom 1)")
                {
                    ApplicationArea = all;
                }
                field("Property Class (Custom 1)"; REC."Property Class (Custom 1)")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Main Asset/Component"; REC."Main Asset/Component")
                {
                    ApplicationArea = all;
                }
                field("Component of Main Asset"; REC."Component of Main Asset")
                {
                    ApplicationArea = all;
                }
                field("FA Add.-Currency Factor"; REC."FA Add.-Currency Factor")
                {
                    ApplicationArea = all;
                }
                field("Use Half-Year Convention"; REC."Use Half-Year Convention")
                {
                    ApplicationArea = all;
                }
                field("Use DB% First Fiscal Year"; REC."Use DB% First Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field("Temp. Ending Date"; REC."Temp. Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Temp. Fixed Depr. Amount"; REC."Temp. Fixed Depr. Amount")
                {
                    ApplicationArea = all;
                }
                field("Ignore Def. Ending Book Value"; REC."Ignore Def. Ending Book Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

