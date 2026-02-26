report 52048903 "Solder Prêt"

//ID dans Nav 2009 : "39001432"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loan & Advance Header"; "Loan & Advance Header")
        {
            CalcFields = "Principal Amount", "Interest Amount";
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                CASE Opt OF
                    0:
                        MESSAGE('Rien a Solder ');
                    //>>MBY 04/05/2009
                    //     1 : Val.Solder("Loan & Advance Header",DateCompta,TypeClass,NumDoc,NumDoc,WORKDATE);
                    1:
                        Val.Solder("Loan & Advance Header", DateCompta, TypeClass,
                                    "Loan & Advance Header"."Bal. Account No.", NumDoc, WORKDATE);
                    //<<MBY
                    2:
                        Val.SolderDepasser("Loan & Advance Header", DateCompta, TypeClass, NumDoc, NumDoc, WORKDATE);

                //     1 : Val.Solder("Loan & Advance Header",DateCompta,TypeClass,NumDoc);
                //     2 : Val.SolderDepasser("Loan & Advance Header",DateCompta,TypeClass,NumDoc);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Type Daction"; Opt)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Type D''action';
                        Visible = true;

                    }
                    field("Type Reglement"; NumDoc)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Type Reglement';
                        trigger OnValidate()
                        begin


                            CLEAR(FrmPay);
                            GetProcess.RESET;
                            FrmPay.LOOKUPMODE := TRUE;
                            //GetProcess.SETRANGE(Suggestions,GetProcess.Suggestions::Salary);
                            FrmPay.SETTABLEVIEW(GetProcess);
                            //IF FORM.RUNMODAL(FORM::"Payment Class List", GetProcess) = ACTION::LookupOK THEN
                            IF FrmPay.RUNMODAL = ACTION::LookupOK THEN
                                FrmPay.GETRECORD(GetProcess);
                            Process := GetProcess;
                            Process.TESTFIELD("Header No. Series");
                            NoSeriesMgt.InitSeries(Process."Header No. Series", Process."Header No. Series", 0D, NumDoc, Nserie);
                            //TypeClass:=Process.Code;

                        END;


                    }
                    field("N° Document"; TypeClass)
                    {
                        ApplicationArea = Basic;
                        Caption = 'N° Document';
                    }
                    field("Date Comptable"; DateCompta)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Date Comptable';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        MESSAGE('%1   %2', NumDoc, TypeClass);
    end;

    var
        Process: Record 10860;
        NoSeriesMgt: Codeunit 396;
        ReglHeader: Record 10865;
        ListeProcess: Page 10860;
        GetProcess: Record 10860;
        FrmPay: Page 10860;
        NumDoc: Code[20];
        TypeClass: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        Nserie: Code[20];
        Opt: Option " ","Solder Restant","solde Dépasser";
        MntSolde: Decimal;
        Val: Codeunit 39001404;
        DateCompta: Date;
}

