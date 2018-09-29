public class Stack {
    private Element current;

    public void push(Element e) {
        e.setNext(this.current);
        this.current = e;
    }

    public Element top() {
        return this.current;
    }

    public boolean pop() {
        if (this.current == null) {
            return false;
        }

        // setNext to null

        this.current = this.current.getNext();
        return true;
    }

    public void print() {
        if (this.isEmpty()) {
            System.out.println("print - Stack is empty");
            return;
        }

        StringBuilder sb = new StringBuilder();
        sb.append("print - Stack contains: ");
        Element e = this.current;
        while (e != null) {
            sb.append(e.getValue());
            sb.append(", ");
            e = e.getNext();
        }
        sb.append("top Element = ");
        sb.append(this.current.getValue());
        System.out.println(sb.toString());
    }

    public boolean isEmpty() {
        return this.current == null;
    }

    public int size() {
        Element e = this.current;
        int i = 0;
        while (e != null) {
            e = e.getNext();
            i++;
        }

        return i;
    }
}
