package com.netscanpro.scanner;

import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class TcpPortScanner {

    private final ExecutorService executorService;

    public TcpPortScanner(int threadCount) {
        this.executorService = Executors.newFixedThreadPool(threadCount);
    }

    public List<Integer> scan(String host, int startPort, int endPort, int timeout)
            throws InterruptedException {

        List<Future<Integer>> futures = new ArrayList<>();

        for (int port = startPort; port <= endPort; port++) {
            final int currentPort = port;

            Future<Integer> future = executorService.submit(() -> {
                if (isPortOpen(host, currentPort, timeout)) {
                    return currentPort;
                }
                return -1;
            });

            futures.add(future);
        }

        List<Integer> openPorts = new ArrayList<>();

        for (Future<Integer> future : futures) {
            try {
                int port = future.get();

                if (port != -1) {
                    openPorts.add(port);
                }
            } catch (ExecutionException e) {
                // Ignore individual scan failures
            }
        }

        return openPorts;
    }

    private boolean isPortOpen(String host, int port, int timeout) {

        try (Socket socket = new Socket()) {

            socket.connect(
                    new InetSocketAddress(host, port),
                    timeout);

            return true;

        } catch (Exception e) {
            return false;
        }
    }

    public void shutdown() {
        executorService.shutdown();
    }
}