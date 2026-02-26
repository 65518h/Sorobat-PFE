Codeunit 8001422 "Sales Text Management"
{
    // #7014 AC 21/04/09
    // //+REF+ADDTEXT DL 23/09/05 Gestion des textes en-tête et pied / document vente


    trigger OnRun()
    begin
    end;

    var
        Text000: label 'There is not enough space to insert extended text lines.';


    procedure CommentText(pSalesHeader: Record "Sales Header"; pTextType: Integer)
    var
        lDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        lDocNo: Code[20];
        "?lStandardType": Option Standard,Long,"Header Text","Footer Text";
        lCommentType: Option " ","Header Text","Footer Text";
        lSalesCommentLine: Record "Sales Comment Line";
        lStandardText: Record "Standard Text";
        "?SalesCommentSheet": Page "Sales Comment Sheet";
        //GL2024 NAVIBAT     lHeaderFooterTextCodes: Page 8001421;
        lRecupTextCode: array[20] of Code[10];
        lDisplayTextList: Boolean;
        lDisplayComment: Boolean;
        lMemoPadManagement: Codeunit "MemoPad Management";
        lMarkupLineNo: Integer;
    begin
        //+REF+ADDTEXT
        lDocType := pSalesHeader."Document Type";
        lDocNo := pSalesHeader."No.";
        if pTextType = 1 then begin
            //#4866  lStandardType := lStandardType::"Header Text";
            lCommentType := Lcommenttype::"Header Text";
        end else begin
            //#4866  lStandardType := lStandardType::"Footer Text";
            lCommentType := Lcommenttype::"Footer Text";
        end;

        lSalesCommentLine.SetRange("Document Type", lDocType);
        lSalesCommentLine.SetRange("No.", lDocNo);
        //#5821
        //lSalesCommentLine.SETRANGE(Type,lCommentType);
        lSalesCommentLine.SetRange("Document Line No.", -Abs(lCommentType));
        //#5821//
        lDisplayTextList := lSalesCommentLine.IsEmpty;
        lDisplayComment := true;

        repeat
            if lDisplayTextList then begin
                Commit;
                //#4866    lStandardText.SETRANGE(Type,lStandardType);
                //#4866    lHeaderFooterTextCodes.wInitCommentType(lStandardType);
                //GL2024 NAVIBAT    lHeaderFooterTextCodes.LookupMode(true);
                //GL2024 NAVIBAT    lHeaderFooterTextCodes.SetTableview(lStandardText);
                /*  //GL2024 NAVIBAT  if lHeaderFooterTextCodes.RunModal = Action::LookupOK then begin
                      lHeaderFooterTextCodes.wRecupSelectedText(lRecupTextCode);
                      GetSelectedText(lDocType, lDocNo, lCommentType, lRecupTextCode, lMarkupLineNo, pSalesHeader);
                      lDisplayComment := true;
                  end;*/

                lSalesCommentLine."Document Type" := lDocType;
                lSalesCommentLine."No." := lDocNo;
                //#5821
                //    lSalesCommentLine.Type := lCommentType;
                lSalesCommentLine."Document Line No." := -Abs(lCommentType);
                //#5821//

                Clear(lRecupTextCode);
                //GL2024 NAVIBAT   Clear(lHeaderFooterTextCodes);
                lDisplayTextList := false;
            end;

            if lDisplayComment then begin
                Commit;

                //Previous version
                /*
                    CLEAR(lMemoPadManagement);
                    lSalesCommentSheet.wInitCommentType(lCommentType);
                    lSalesCommentSheet.SETTABLEVIEW(lSalesCommentLine);
                    lSalesCommentSheet.RUNMODAL;
                */
                //Previous version//

                Page.RunModal(Page::"Sales Comment Sheet", lSalesCommentLine);
                AnalyzeText(lDocType, lDocNo, lCommentType, lDisplayTextList, lDisplayComment);
                DeleteMarkupLine(lDocType, lDocNo, lCommentType, lMarkupLineNo);
                //CLEAR(lSalesCommentSheet);
            end;
        until (not lDisplayTextList) and (not lDisplayComment);
        //+REF+ADDTEXT//

    end;


    procedure GetSelectedText(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt"; pDocNo: Code[20]; pTextType: Option " ","Header Text","Footer Text"; pTextCode: array[20] of Code[10]; pMarkupLineNo: Integer; pSalesHeader: Record "Sales Header")
    var
        lSalesCommentLine: Record "Sales Comment Line";
        i: Integer;
    begin
        //+REF+ADDTEXT
        lSalesCommentLine."Document Type" := pDocType;
        lSalesCommentLine."No." := pDocNo;
        //#5821
        //lSalesCommentLine.Type := pTextType;
        lSalesCommentLine."Document Line No." := -Abs(pTextType);
        //#5821//
        lSalesCommentLine."Line No." := pMarkupLineNo;
        for i := 1 to 20 do
            if pTextCode[i] <> '' then
                AddNewText(pTextCode[i], lSalesCommentLine, pSalesHeader);
        //+REF+ADDTEXT//
    end;


    procedure AnalyzeText(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt"; pDocNo: Code[20]; pTextType: Option " ","Header Text","Footer Text"; var pDisplayList: Boolean; var pDisplayComment: Boolean): Boolean
    var
        lSalesCommentLine: Record "Sales Comment Line";
        lTextCode: Code[10];
        p: Integer;
        lSalesHeader: Record "Sales Header";
    begin
        //+REF+ADDTEXT
        lSalesCommentLine.SetRange("Document Type", pDocType);
        lSalesCommentLine.SetRange("No.", pDocNo);
        //#5821
        //lSalesCommentLine.SETRANGE(Type,pTextType);
        lSalesCommentLine."Document Line No." := -Abs(pTextType);
        //#5821//
        lSalesHeader.Get(pDocType, pDocNo);

        pDisplayList := false;
        pDisplayComment := false;
        with lSalesCommentLine do
            if lSalesCommentLine.Find('-') then
                repeat
                    if CopyStr(Comment, 1, 1) = '#' then begin
                        if StrLen(Comment) > 1 then begin
                            p := StrPos(Comment, ' ');
                            if p > 0 then
                                lTextCode := CopyStr(Comment, 2, p - 2)
                            else
                                lTextCode := CopyStr(Comment, 2);
                            lTextCode := UpperCase(lTextCode);
                            AddNewText(lTextCode, lSalesCommentLine, lSalesHeader);
                            pDisplayComment := true;
                        end else
                            pDisplayList := true;
                    end;
                until Next = 0;
        //+REF+ADDTEXT//
    end;


    procedure AddNewText(pTextCode: Code[10]; pSalesCommentLine: Record "Sales Comment Line"; pSalesHeader: Record "Sales Header")
    var
        lExtendedTextLine: Record "Extended Text Line";
        lExtendedTextLine2: Record "Extended Text Line";
        lSalesCommentLine: Record "Sales Comment Line";
        i: Integer;
        lNextLineNo: Integer;
        lLineSpacing: Integer;
    begin
        //+REF+ADDTEXT
        //lSalesHeader.GET(pSalesCommentLine."Document Type",pSalesCommentLine."No.");
        lExtendedTextLine.SetRange("Table Name", lExtendedTextLine."table name"::"Standard Text");
        lExtendedTextLine.SetRange("No.", pTextCode);
        lExtendedTextLine.SetRange("Language Code", '');
        if pSalesHeader."Language Code" <> '' then begin
            lExtendedTextLine.SetRange("Language Code", pSalesHeader."Language Code");
            if not lExtendedTextLine.Find('-') then
                lExtendedTextLine.SetRange("Language Code", '');
        end;

        lSalesCommentLine.SetRange("Document Type", pSalesCommentLine."Document Type");
        lSalesCommentLine.SetRange("No.", pSalesCommentLine."No.");
        //#5821
        //lSalesCommentLine.SETRANGE(Type,pSalesCommentLine.Type);
        lSalesCommentLine.SetRange("Document Line No.", pSalesCommentLine."Document Line No.");
        //#5821//
        lSalesCommentLine := pSalesCommentLine;
        if lSalesCommentLine.Find('>') then begin
            lLineSpacing :=
              (lSalesCommentLine."Line No." - pSalesCommentLine."Line No.") DIV
              (1 + lExtendedTextLine.Count);
            if lLineSpacing = 0 then
                Error(Text000);
        end else
            lLineSpacing := 10000;

        lNextLineNo := pSalesCommentLine."Line No." + lLineSpacing;
        if pSalesCommentLine."Line No." = 0 then begin
            if lSalesCommentLine.Find('+') then;
            lLineSpacing := 10000;
            lNextLineNo := lSalesCommentLine."Line No." + lLineSpacing;
        end;

        if lExtendedTextLine.Find('-') then
            repeat
                lSalesCommentLine.Init;
                lSalesCommentLine."Document Type" := pSalesCommentLine."Document Type";
                lSalesCommentLine."No." := pSalesCommentLine."No.";
                lSalesCommentLine."Line No." := lNextLineNo;
                lNextLineNo += lLineSpacing;
                lSalesCommentLine.Comment := lExtendedTextLine.Text;
                /*#5464
                    lSalesCommentLine.Comment2 := lExtendedTextLine."Text 2";
                //#5464*/
                //#5821
                //    lSalesCommentLine.Type := pSalesCommentLine.Type;
                pSalesCommentLine."Document Line No." := pSalesCommentLine."Document Line No.";
                //#5821//

                lExtendedTextLine2.Copy(lExtendedTextLine);
                lExtendedTextLine2 := lExtendedTextLine;
                if lExtendedTextLine2.Next = 0 then
                    lSalesCommentLine.Separator := 1
                else
                    lSalesCommentLine.Separator := lExtendedTextLine.Separator;
                lSalesCommentLine.Insert;
            until lExtendedTextLine.Next = 0;
        //+REF+ADDTEXT//

    end;


    procedure DeleteMarkupLine(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt"; pDocNo: Code[20]; pTextType: Option " ","Header Text","Footer Text"; var pMarkupLineNo: Integer)
    var
        lSalesCommentLine: Record "Sales Comment Line";
    begin
        //+REF+ADDTEXT
        pMarkupLineNo := 0;
        with lSalesCommentLine do begin
            //#5821
            //  SETRANGE(Type,pTextType);
            SetRange("Document Line No.", -Abs(pTextType));
            //#5821//
            SetRange("Document Type", pDocType);
            SetRange("No.", pDocNo);
            if Find('-') then
                repeat
                    if CopyStr(Comment, 1, 1) = '#' then begin
                        if pMarkupLineNo = 0 then
                            pMarkupLineNo := lSalesCommentLine."Line No.";
                        Delete;
                    end;
                until Next = 0;
        end;
        //+REF+ADDTEXT//
    end;
}

