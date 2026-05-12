Codeunit 8004063 "Sales Cross-Ref Group Mgt"
{

    trigger OnRun()
    begin
    end;

    var
        Text8003900: label 'You are going to ungroup this Cross-Refernce and its associed lignes. \ Do you want to continue this work?';
        Text8003901: label 'You must ungroup the cross-Réf. before to delete this line.';


    procedure wGroup(var Rec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesLineStruct: Record "Sales Line";
        lxRec: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        lQteBase: Decimal;
        lCrossRefLineNo: Integer;
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        lNaviBatSetup: Record NavibatSetup;
    begin
        with Rec do begin
            //#7594
            lNaviBatSetup.GET2;
            lNaviBatSetup.TestField("Specific Struct. Price Calcul", true);
            //#7594//
            if ("Cross-Ref. Line No." <> 0) and ("Cross-Ref. Line No." <> "Line No.") then
                if Get("Document Type", "Document No.", "Cross-Ref. Line No.") then;

            lxRec := Rec;
            if ("Cross-Ref. Line No." in [0, "Line No."]) then begin
                lSetFilterCrossRefLine(lSalesLine, Rec);
                lSalesLine.SetFilter("Cross-Ref. Line No.", '<>%2&<>%1', 0, "Line No.");
                lSalesLine.SetRange(Option, false);
                if not lSalesLine.IsEmpty then begin
                    lSalesLine.FindFirst;
                    lSalesLine."Quantity (Base)" += "Quantity (Base)";
                    lSalesLine.Modify;
                    "Quantity (Base)" := 0;
                    "Cross-Ref. Line No." := lSalesLine."Line No.";
                    lStructureMgt.DeleteStructure(Rec);
                    Validate(Quantity);
                    "Unit Cost (LCY)" := 0;
                    "Overhead Amount (LCY)" := 0;
                    "Theoretical Profit Amount(LCY)" := 0;
                    Modify;
                    lCrossRefLineNo := "Cross-Ref. Line No.";
                end
                else begin
                    lSalesLine.Reset;
                    lSetFilterCrossRefLine(lSalesLine, Rec);
                    lSalesLine.SetRange(Option, false);

                    lSalesLine.CalcSums("Quantity (Base)");
                    lQteBase := lSalesLine."Quantity (Base)";
                    lCrossRefLineNo := 0;
                    lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.");
                    if lSalesLine.Find('-') then
                        repeat
                            if lCrossRefLineNo = 0 then begin
                                lCrossRefLineNo := lSalesLine."Line No.";
                                lSalesLine."Quantity (Base)" := lQteBase;
                            end;
                            lSalesLine."Cross-Ref. Line No." := lCrossRefLineNo;
                            lSalesLine.Modify;
                            if lSalesLine."Line No." <> lCrossRefLineNo then begin
                                lStructureMgt.DeleteStructure(lSalesLine);
                                lSalesLine."Quantity (Base)" := 0;
                                lSalesLine."Unit Cost (LCY)" := 0;
                                lSalesLine."Overhead Amount (LCY)" := 0;
                                lSalesLine."Theoretical Profit Amount(LCY)" := 0;
                            end;
                            lSalesLine.Validate(Quantity);
                            lSalesLine.Modify;
                        until lSalesLine.Next = 0;
                end;
            end;
            if lSalesLine.Get("Document Type", "Document No.", lCrossRefLineNo) then
                lSalesCrossRefMgt.wUpdateField(lSalesLine, lSalesLine."Unit Price", lSalesLine.FieldNo("Unit Price"));
            wUpdateLine(Rec, lxRec, false);
            Find('=');
        end;
    end;


    procedure wUnGroup(var rec: Record "Sales Line"; pKoConfirm: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lxRec: Record "Sales Line";
        lstructureMng: Codeunit "Structure Management";
        lUpdateOK: Boolean;
    begin
        with rec do begin
            lxRec := rec;
            if ("Cross-Ref. Line No." = "Line No.") then begin
                lSetFilterCrossRefLine(lSalesLine, rec);
                lSalesLine.SetRange("Cross-Ref. Line No.", "Line No.");
                lSalesLine.SetRange(Option, false);
                if not lSalesLine.IsEmpty then begin
                    if not pKoConfirm then
                        if not Confirm(Text8003900, false) then
                            Error('');
                    lSalesLine.Find('-');
                    repeat
                        wUnGroup(lSalesLine, false);
                    until lSalesLine.Next = 0;
                end;
            end;
            lUpdateOK := "Cross-Ref. Line No." = "Line No.";
            if lSalesLine.Get("Document Type", "Document No.", "Cross-Ref. Line No.") then begin
                lSalesLine.Validate("Quantity (Base)", lSalesLine."Quantity (Base)" - Quantity);
                Find('=');
                //#6814
                "Cross-Ref. Line No." := 0;
                Modify;
                //#6814//
                Validate("Quantity (Base)", Quantity * rec."Qty. per Unit of Measure");
                Modify;
                if "Line No." <> lSalesLine."Line No." then
                    lstructureMng.wInsertStructure(lSalesLine, rec, 0, 0, lSalesLine."Job No.");
                Get("Document Type", "Document No.", "Line No.");
                wUpdateLine(rec, lxRec, lUpdateOK);
            end;
        end;
    end;


    procedure lSetFilterCrossRefLine(var pRec: Record "Sales Line"; pCrossRefRec: Record "Sales Line")
    begin
        with pCrossRefRec do begin
            pRec.Reset;
            pRec.SetCurrentkey("Document Type", "Document No.", "Line Type", "Item Reference No.");
            pRec.SetRange("Document Type", "Document Type");
            pRec.SetRange("Document No.", "Document No.");
            pRec.SetRange("Line Type", "Line Type");
            pRec.SetRange("Item Reference No.", "Item Reference No.");
            pRec.SetRange("Structure Line No.", 0);
            pRec.SetFilter("Line No.", '<>%1', "Line No.");
        end;
    end;
}

