```
package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

public class MyFTP {

    FTPClient ftpClient = new FTPClient();
    
	public static void main(String[] args) throws FileNotFoundException, IOException {
		// TODO Auto-generated method stub

		  
		  MyFTP my = new MyFTP ();
		  my.upload("/Users/lucasko/Downloads/swagger.zip", "/home/root/");
		  System.out.println("done");
	
		
	}

    
    private List<FtpServer> getServers() {
    
     	FtpServer ftpServer = new FtpServer();
     	ftpServer.setServer("127.0.0.1");
     	ftpServer.setPassword("ftp");
     	
    	FtpServer ftpServer2 = new FtpServer();
    	ftpServer2.setServer("localhost");
    	ftpServer2.setPassword("ftp");
    	
    	List<FtpServer> list=Arrays.asList(ftpServer ,ftpServer2);
    	return list;
    	
    }
    
    
    public void upload(String src , String dest) throws IOException,FileNotFoundException {
    	
    	File srcFile = new File(src);
    	if(! srcFile.exists())
    	{
        	throw new FileNotFoundException(src+" not found.");
    	}
        	
    	List<FtpServer> list = this.getServers();
    	FileInputStream fis = null;
   


    	//ftpClient.enterLocalActiveMode();

    	try {
    		
    		ftpClient.connect("localhost");
    		ftpClient.login("root", "123456");
        	//ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
        	//ftpClient.enterLocalPassiveMode();

    	    //
    	    // Create an InputStream of the file to be uploaded
    	    //
    	    fis = new FileInputStream(srcFile);

    	    //
    	    // Store file to server
    	    //
    	    boolean done = ftpClient.storeFile( new File(dest, srcFile.getName() ).getAbsolutePath(), fis);
    	    System.out.println("done="+done);
    	    ftpClient.logout();
    	} catch (IOException e) {
    	System.out.println(e.getMessage());
    	  throw new IOException ();
    	} finally {
    	    try {
    	        if (fis != null) {
    	            fis.close();
    	        }
    	        ftpClient.disconnect();
    	    } catch (IOException e) {
    	        e.printStackTrace();
    	    }
    	}
    	
    	
    }

	
	class FtpServer{
		String server;
	    public String getServer() {
			return server;
		}
		public void setServer(String server) {
			this.server = server;
		}
		public int getPort() {
			return port;
		}
		public void setPort(int port) {
			this.port = port;
		}
		public String getUser() {
			return user;
		}
		public void setUser(String user) {
			this.user = user;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		int port ;
	    String user ;
	    String password ;
	    String type;
	}
	
}



```