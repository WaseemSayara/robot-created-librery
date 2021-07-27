from SSHLibrary import *
__version__ = '0.1'


class TestSSH:
    client = SSHLibrary()
    ROBOT_LIBRARY_SCOPE = 'TEST CASE'

    def login_to_host(self, ip, port, username, password):
        self.client.open_connection(ip, port=port)
        output = self.client.login(username, password)
        if 'Welcome to' in output:
            return 1
        else:
            return 0

    def execute_command(self, command):
        output = self.client.execute_command(command)
        return output

    def get_hostname(self):
        hostname = self.execute_command('hostname')
        return hostname

    def get_network_configurations(self):
        network = self.execute_command('ifconfig')
        return network

    def create_directory(self, dir_name):
        directory = self.execute_command('mkdir ' + str(dir_name))
        return directory

    def directory_should_exist(self, dir_name):
        return self.client.directory_should_exist(dir_name)

    def file_should_exist(self, file_name):
        return self.client.file_should_exist(file_name)

    def create_file(self, file_name, file_content, directory):
        self.execute_command('touch ' + str(directory).strip() + '/' + str(file_name))
        file = self.execute_command('echo ' + "\' " + str(file_content) + "\' >" + str(directory).strip() +
                                    '/' + str(file_name))
        return file

    def get_file(self, source, destination):
        file = self.client.get_file(source=source, destination=destination)
        return file

    def remove_file(self, file_name):
        file = self.execute_command('rm ' + str(file_name))
        return file

    def remove_files_in_directory(self, directory):
        directory = self.execute_command('rm ' + str(directory).strip() + '/*')
        return directory

    def put_directory(self, source, destination):
        directory = self.client.put_directory(source=source, destination=destination)
        return directory

    def put_file(self, source, destination):
        file = self.client.put_file(source=source, destination=destination)
        return file

    def logout_from_host(self):
        self.client.close_connection()
        return
