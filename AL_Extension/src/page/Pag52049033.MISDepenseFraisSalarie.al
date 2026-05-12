page 52049033 "MIS-Depense Frais/Salarie"
{  //GL2024  ID dans Nav 2009 : "39001561"
    Caption = 'Depanse Frais /Salarier';
    PageType = List;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            field(EmployeeNoFilter; EmployeeNoFilter)
            {
                ApplicationArea = all;
                Caption = 'Filtre Salarié';
            }
            field(FiltreDate; FiltreDate)
            {
                ApplicationArea = all;
                Caption = 'Filtre Date';
            }
            repeater("<Control1000000002>")
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }

                field(DecLMontant; DecLMontant)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        EmployeeAbsence: Record "Employee Absence";
        // PeriodFormMgt: Codeunit 359;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";
        EmployeeNoFilter: Code[20];
        DecLMontant: Decimal;
        FiltreDate: Text[30];


    procedure MatrixUpdate()
    begin

        //CurrForm.Matrix.MatrixRec.SETRANGE("Frais de mission",TRUE);
        //CurrForm.Matrix.MatrixRec.SETRANGE("Employee filter","No.");
        //CurrForm.Matrix.MatrixRec.SETFILTER("Date Filter",FiltreDate);
        //FiltreDate:=CurrForm.Matrix.MatrixRec.GETFILTER("Date Filter");
    end;
}

