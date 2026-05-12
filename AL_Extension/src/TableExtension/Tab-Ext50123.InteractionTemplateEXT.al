TableExtension 50123 "Interaction TemplateEXT" extends "Interaction Template"
{
    fields
    {
        modify("Attachment No.")
        {
            trigger OnBeforeValidate()
            begin
                //+REF+MAILING
                fUpdateAttachmentLink;
                //+REF+MAILING// 
            end;
        }

        field(8001400; "Direct Mailing Code"; Code[10])
        {
            Caption = 'Direct Mailing Code';
            TableRelation = "Direct Mailing";

            trigger OnValidate()
            begin
                //+REF+MAILING
                fUpdateAttachmentLink;
                //+REF+MAILING//
            end;
        }
    }

    procedure fUpdateAttachmentLink()
    var
        lAttachment: Record Attachment;
    begin
        //+REF+MAILING
        if "Attachment No." <> 0 then
            if lAttachment.Get("Attachment No.") then begin
                lAttachment."Direct Mailing Code" := "Direct Mailing Code";
                lAttachment.Modify;
            end;
        //+REF+MAILING//
    end;
}

