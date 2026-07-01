interface Document {
    void open();
}

// Concrete Documents
class WordDocument implements Document {
    public void open() {
        System.out.println("Word Document Opened");
    }
}

class PdfDocument implements Document {
    public void open() {
        System.out.println("PDF Document Opened");
    }
}

class ExcelDocument implements Document {
    public void open() {
        System.out.println("Excel Document Opened");
    }
}

// Abstract Factory
abstract class DocumentFactory {
    abstract Document createDocument();
}

// Concrete Factories
class WordFactory extends DocumentFactory {
    Document createDocument() {
        return new WordDocument();
    }
}

class PdfFactory extends DocumentFactory {
    Document createDocument() {
        return new PdfDocument();
    }
}

class ExcelFactory extends DocumentFactory {
    Document createDocument() {
        return new ExcelDocument();
    }
}

// Main Class (Filename: FactoryMethod.java)
public class FactoryMethod {
    public static void main(String[] args) {

        DocumentFactory f1 = new WordFactory();
        f1.createDocument().open();

        DocumentFactory f2 = new PdfFactory();
        f2.createDocument().open();

        DocumentFactory f3 = new ExcelFactory();
        f3.createDocument().open();
    }
}
