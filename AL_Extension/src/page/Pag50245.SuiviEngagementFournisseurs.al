Page 50245 "Suivi Engagement Fournisseurs"
{
    PageType = Card;
    SourceTable = Vendor;
    SourceTableView = sorting("No.");
    ApplicationArea = all;
    Caption = 'Suivi Engagement Fournisseurs';
    layout
    {
        area(content)
        {

            group("Général")
            {
                Caption = 'Général';
                field(OnlyInvoice; OnlyInvoice)
                {
                    ApplicationArea = all;
                }
                field(Periode; Periode)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                        CalcM := Periode;
                        FirstDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
                        FirstDate := CALCDATE('-1M', FirstDate);
                        LastDate := CALCDATE(FORMAT(CalcM + 1) + 'M', FirstDate);
                        //GL2024      CurrPage.Matrix.MatrixRec.SETRANGE("Period Type", CurrPage.Matrix.MatrixRec."Period Type"::"2");
                        //GL2024     CurrPage.Matrix.MatrixRec.SETRANGE(CurrPage.Matrix.MatrixRec."Period Start", FirstDate, LastDate);
                        InitialiseValCol;
                    end;
                }
                field(NomFournisseur; NomFournisseur)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                        rec.RESET;
                        IF NomFournisseur <> '' THEN rec.SETFILTER(rec.Name, '*' + NomFournisseur + '*');
                        InitialiseValCol;
                    end;
                }
                field(LocalEtranger; LocalEtranger)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                        rec.RESET;
                        IF LocalEtranger <> 0 THEN BEGIN
                            IF LocalEtranger = LocalEtranger::"Local" THEN rec.SETFILTER("Gen. Bus. Posting Group", '*LOC*');
                            IF LocalEtranger = LocalEtranger::Etranger THEN rec.SETFILTER("Gen. Bus. Posting Group", '*ETR*');
                        END;
                        InitialiseValCol;
                    end;
                }


            }
            /* GL2024    group("Matrix")
                 {



                     repeater(Control1)
                     {
                         Editable = false;
                         ShowCaption = false;
                         field("No."; Rec."No.")
                         {
                             ApplicationArea = all;
                         }
                         field(Name; Rec.Name)
                         {
                             ApplicationArea = all;
                         }
                     }
                     repeater(Control12)
                     {
                         ShowCaption = false;
                         field(ValEntete1; ValEntete)
                         {

                             ApplicationArea = all;
                         }
                         field(Val1; Val)
                         {
                             ApplicationArea = all;
                             trigger OnAssistEdit()
                             begin

                                 VendorLedgerEntry.SETRANGE("Vendor No.", rec."No.");
                                //GL2024    IF FirstDate = CurrPage.Matrix.MatrixRec."Period Start" THEN
                                       //GL2024   VendorLedgerEntry.SETRANGE("Due Date", 010101D, CurrPage.Matrix.MatrixRec."Period Start")
                                       //GL2024 
                                       VendorLedgerEntry.SETRANGE("Due Date", 20010101D, CurrPage.Matrix.MatrixRec."Period Start")
                                   //GL2024 
                                   ELSE
                                       VendorLedgerEntry.SETRANGE("Due Date", CurrPage.Matrix.MatrixRec."Period Start",
                                        CALCDATE('FM', CurrPage.Matrix.MatrixRec."Period Start"));*/
            //GL202   page.RUNMODAL(29, VendorLedgerEntry);

            //GL202 end;
            //GL202 }

            //GL202 }
            //GL202 }*/
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Totaux")
            {
                ApplicationArea = all;
                Caption = 'Update Totaux';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CalculerTotal;
                end;
            }
        }
    }

    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Val: Decimal;
        FirstDate: Date;
        LastDate: Date;
        OnlyInvoice: Boolean;
        Periode: Option " ","1M","2M","3M","4M","5M","6M";
        CalcM: Integer;
        NomFournisseur: Text[30];
        LocalEtranger: Option " ","Local",Etranger;
        ValEntete: Text[30];
        TotVal: Decimal;
        ValCol: array[12] of Decimal;
        MadAte: Date;
        ValCol1Ok: Boolean;
        FirstVendor: Code[20];
        LastVendor: Code[20];
        RecVendor: Record Vendor;
        i: Integer;
        j: Integer;

    trigger OnOpenPage()
    begin

        rec.RESET;
        Periode := Periode::"6M";
        CalcM := Periode - 1;
        FirstDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        FirstDate := CALCDATE('-1M', FirstDate);
        LastDate := CALCDATE(FORMAT(CalcM + 1) + 'M', FirstDate);
        //GL2024    CurrPage.Matrix.MatrixRec.SETRANGE("Period Type", CurrPage.Matrix.MatrixRec."Period Type"::"2");
        //GL2024     CurrPage.Matrix.MatrixRec.SETRANGE(CurrPage.Matrix.MatrixRec."Period Start", FirstDate, LastDate);
        //SETFILTER("No.",'%1..%2','FRE-0050','FRE-0059');
    end;

    trigger OnAfterGetRecord()
    begin

        TotVal := 0;
        i += 1;
        IF i = 1 THEN
            FirstVendor := rec."No."
        ELSE IF rec."No." <> 'TOT' THEN LastVendor := rec."No.";
    end;

    procedure UpdateMatrice()
    begin

        Val := 0;
        /* //GL2024    IF LastDate <> CurrPage.Matrix.MatrixRec."Period Start" THEN
              ValEntete := FORMAT(CurrPage.Matrix.MatrixRec."Period Start")
          ELSE BEGIN
              ValEntete := 'TOTAL';
              Val := TotVal;
          END;
          VendorLedgerEntry.SETRANGE("Vendor No.", rec."No.");
          IF FirstDate = CurrPage.Matrix.MatrixRec."Period Start" THEN

              //GL2024   VendorLedgerEntry.SETRANGE("Due Date",010101D,CurrPage.Matrix.MatrixRec."Period Start")
              //GL2024 
              VendorLedgerEntry.SETRANGE("Due Date", 20010101D, CurrPage.Matrix.MatrixRec."Period Start")
          //GL2024 
          ELSE
              VendorLedgerEntry.SETRANGE("Due Date", CurrPage.Matrix.MatrixRec."Period Start",
               CALCDATE('FM', CurrPage.Matrix.MatrixRec."Period Start"));
          IF OnlyInvoice THEN
              VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice)
          ELSE
              VendorLedgerEntry.SETRANGE("Document Type");
          VendorLedgerEntry.SETCURRENTKEY("Document Type", "Vendor No.", "Due Date");
         IF CurrPage.Matrix.MatrixRec."Period Start" <> LastDate THEN BEGIN
              IF VendorLedgerEntry.FINDFIRST THEN
                  REPEAT
                      VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                      Val += VendorLedgerEntry."Remaining Amount";
                      TotVal += VendorLedgerEntry."Remaining Amount";
                  UNTIL VendorLedgerEntry.NEXT = 0;

          END;*/
    end;


    procedure CalculerTotal()
    begin

        RecVendor.RESET;
        RecVendor.COPY(Rec);
        IF RecVendor.FINDFIRST THEN
            REPEAT
                VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                FOR i := 1 TO CalcM DO BEGIN
                    FirstDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
                    FirstDate := CALCDATE('-1M', FirstDate);
                    IF i = 1 THEN
                        //GL2024   VendorLedgerEntry.SETRANGE("Due Date",010101D,FirstDate)
                        //GL2024 
                        VendorLedgerEntry.SETRANGE("Due Date", 20010101D, FirstDate)
                    //GL2024 
                    ELSE BEGIN
                        LastDate := CALCDATE(FORMAT(i + 1) + 'M', FirstDate);
                        VendorLedgerEntry.SETRANGE("Due Date", LastDate,
                        CALCDATE('FM', LastDate));
                    END;
                    IF OnlyInvoice THEN
                        VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice)
                    ELSE
                        VendorLedgerEntry.SETRANGE("Document Type");
                    VendorLedgerEntry.SETCURRENTKEY("Document Type", "Vendor No.", "Due Date");
                    IF i <> CalcM THEN BEGIN
                        IF VendorLedgerEntry.FINDFIRST THEN
                            REPEAT
                                VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                                ValCol[i] += VendorLedgerEntry."Remaining Amount";

                            UNTIL VendorLedgerEntry.NEXT = 0;

                    END;

                END;
            UNTIL RecVendor.NEXT = 0;
    end;


    procedure InitialiseValCol()
    begin

        FOR j := 1 TO 6 DO BEGIN
            ValCol[j] := 0;
        END;

    end;
}

